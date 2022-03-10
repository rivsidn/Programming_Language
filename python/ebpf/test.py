#!/usr/bin/python

from __future__ import print_function
from bcc import BPF
from time import sleep, strftime

bpf_text = """
#include <uapi/linux/ptrace.h>
#include <linux/sched.h>

BPF_HASH(table, u32, u32);

int switch_start(struct pt_regs *ctx, struct task_struct *prev)
{
    u32 cur_pid = bpf_get_current_pid_tgid();
    u32 prev_pid = prev->pid;
    table.update(&prev_pid, &cur_pid);
    return 0;
}
"""

b = BPF(text=bpf_text)
b.attach_kprobe(event="finish_task_switch", fn_name="switch_start")

table = b.get_table("table")

print("%-10s%-10s"%("prev_pid", "cur_pid"))
while (1):
    try:
        sleep(1);
        for k,v in table.items():
            print("%-10d%-10d"%(k.value, v.value))
        table.clear()
    except KeyboardInterrupt:
        exit()
