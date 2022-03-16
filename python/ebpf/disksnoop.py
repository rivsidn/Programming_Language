#!/usr/bin/python

from __future__ import print_function
from bcc import BPF
from bcc.utils import printb

REQ_WRITE = 1

# load BPF program
prog = """
#include <uapi/linux/ptrace.h>
#include <linux/blk-mq.h>

BPF_HASH(start, struct request *);

//第一个参数为 ctx
//第二个参数为 req，为函数的实际参数
void trace_start(struct pt_regs *ctx, struct request *req) {
    // stash start timestamp by request ptr
    u64 ts = bpf_ktime_get_ns();

    start.update(&req, &ts);
}

void trace_completion(struct pt_regs *ctx, struct request *req) {
    u64 *tsp, delta;

    tsp = start.lookup(&req);
    if (tsp != 0) {
        delta = bpf_ktime_get_ns() - *tsp;
        bpf_trace_printk("%d %x %d\\n", req->__data_len, req->cmd_flags, delta/1000);
        start.delete(&req);
    }
}
"""

b = BPF(text=prog)

if BPF.get_kprobe_functions(b'blk_start_request'):
    b.attach_kprobe(event="blk_start_request", fn_name="trace_start")
b.attach_kprobe(event="blk_mq_start_request", fn_name="trace_start")
if BPF.get_kprobe_functions(b"__blk_account_in_done"):
    b.attach_kprobe(event="__blk_account_io_inode", fn_name="trace_completion")
else:
    b.attach_kprobe(event="blk_account_io_done", fn_name="trace_completion")

while 1:
    try:
        (task, pid, cpu, flags, ts, msg) = b.trace_fields()
        (bytes_s, bflags_s, us_s) = msg.split()

        if int(bflags_s, 16) & REQ_WRITE:
            types_s = b"W"
        elif bytes_s == "0":
            types_s = b"M"
        else:
            types_s = b"R"
        ms = float(int(us_s, 10)) / 1000

        printb(b"%-18.9f %-2s %-7s %8.2f" % (ts, types_s, bytes_s, ms))
    except KeyboardInterrupt:
        exit()

