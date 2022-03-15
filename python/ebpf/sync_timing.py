from __future__ import print_function
from bcc import BPF

# load BPF program
prog = """
#include <uapi/linux/ptrace.h>

/* 当作一个全局变量，存储之前的值 */
BPF_HASH(last);

int do_trace(struct pt_regs *ctx) {
    //ts    时间
    //tsp   之前时间
    //delta 时间间隔
    //key   hash表中的键值，只用到了key=0
    u64 ts, *tsp, delta, key = 0;

    //尝试读取之前的时间，如果有则之前的时间且时间
    //间隔在1s之内，则输出.
    tsp = last.lookup(&key);
    if (tsp != NULL) {
        delta = bpf_ktime_get_ns() - *tsp;
        if (delta < 1000000000) {
            //output if time is less than 1 second
            bpf_trace_printk("%d\\n", delta/1000000);
        }
        last.delete(&key);
    }

    //update stored timestamp
    ts = bpf_ktime_get_ns();
    last.update(&key, &ts);
    return 0;
}
"""

b = BPF(text = prog)
b.attach_kprobe(event=b.get_syscall_fnname("sync"), fn_name="do_trace")
print("Tracing for quick sync's... Ctrl-C to end")

# format output
start = 0
while 1:
    (task, pid, cpu, flags, ts, msg) = b.trace_fields()
    if start == 0:
        start = ts
    ts = ts - start
    print("At time %.2f s: multiple syncs detected, last %s ms ago" % (ts, msg))

