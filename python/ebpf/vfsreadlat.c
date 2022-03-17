#include <uapi/linux/ptrace.h>

//创建两个与用户态交互通道:
//一个是hash 表
//另一个是直方图
BPF_HASH(start, u32);
BPF_HISTOGRAM(dist);

//开始时的回调函数
//获取进程号，以进程号为key值保存时间戳
int do_entry(struct pt_regs *ctx)
{
	u32 pid;
	u64 ts, *val;

	pid = bpf_get_current_pid_tgid();
	ts = bpf_ktime_get_ns();
	start.update(&pid, &ts);
	return 0;
}

//结束时的回调函数
//获取进程号，以进程号为key值获取之前时间戳
//获取当前时间，计算时间间隔，保存到直方图中
int do_return(struct pt_regs *ctx)
{
	u32 pid;
	u64 *tsp, delta;

	pid = bpf_get_current_pid_tgid();
	tsp = start.lookup(&pid);

	if (tsp != 0) {
		delta = bpf_ktime_get_ns() - *tsp;
		dist.increment(bpf_log2l(delta/1000));
		start.delete(&pid);
	}

	return 0;
}
