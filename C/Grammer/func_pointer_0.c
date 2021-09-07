#include <stdio.h>

/* 函数指针使用 */

#define DEBUG_TRACEPOINT

#ifdef DEBUG_TRACEPOINT

#define HOOKS_SIZE 32

struct __trace_hook {
	void (*func)(void *);
} hooks[HOOKS_SIZE];

void demo_hook(void *data)
{
	printf("demo hook call...\n");
	return;
}

int register_trace_hook(void (*func)(void *))
{
	int i;
	struct __trace_hook *hook = hooks;

	for (i = 0; i < HOOKS_SIZE; i++) {
		if (hook->func == NULL) {
			hook->func = func;
			return 0;
		}
		hook++;
	}

	return -1;
}

void unregister_trace_hook()
{
	//TODO:...
}

void trace_func()
{
	struct __trace_hook *hook = hooks;

	if (hook->func) {
		do {
			hook->func(NULL);
		} while ((++hook)->func);
	}
}
#else

#define trace_func()

#endif

void func()
{
	printf("before tracing...\n");

	trace_func();

	printf("after tracing...\n");
}

int main()
{
#ifdef DEBUG_TRACEPOINT
	//注册钩子函数
	int ret = register_trace_hook(demo_hook);
	if (ret != 0) {
		//error...
	}
#endif

	func();

	return 0;
}
