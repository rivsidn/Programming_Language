#include <uapi/linux/ptrace.h>
#include <linux/sched.h>

struct key_t {
	u32 prev_pid;
	u32 curr_pid;
};

/* 创建hash表，参数分别为: 名称、键值、数值、大小 */
BPF_HASH(stats, struct key_t, u64, 1024);

int count_sched(struct pt_regs *ctx, struct task_struct *prev) {
	struct key_t key = {};
	u64 zero = 0, *val;

	key.curr_pid = bpf_get_current_pid_tgid();
	key.prev_pid = prev->pid;

	val = stats.lookup_or_try_init(&key, &zero);
	if (val) {
		(*val)++;
	}
	return 0;
}
