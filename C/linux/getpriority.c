#include <stdio.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/resource.h>
#include <unistd.h>

int main()
{
	volatile int i, j;

	id_t pid = getpid();

	printf("pid %d nice %d\n", pid, getpriority(PRIO_PROCESS, pid));

	for (;;) {
		i = j+i;
		j = i+j;
	}

	return 0;
}

