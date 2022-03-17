from bcc import BPF
from time import sleep

b= BPF(src_file="task_switch.c")
b.attach_kprobe(event="finish_task_switch", fn_name="count_sched")

# 生成多个调度事件
for i in range(0, 100): sleep(0.01)

for k,v in b["stats"].items():
    print("task_switch[%5d->%5d]=%u" % (k.prev_pid, k.curr_pid, v.value))
