#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int global_int = 10;

void child(void)
{
	int i = 0;
	global_int = 20;
	while (i++ < 10) {
		printf("child %d\n", global_int);
		sleep(1);
	}
}

void parent(void)
{
	int i = 0;
	global_int = 30;
	while (i++ < 10) {
		printf("parent %d\n", global_int);
		sleep(1);
	}
}

int main()
{
	pid_t ret;

	ret = fork();
	if (ret == -1) {
		fprintf(stderr, "error\n");
		return -1;
	}

	if (ret == 0) {		//子进程
		child();
	} else {		//父进程
		parent();
	}

	return 0;
}
