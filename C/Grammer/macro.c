#include <stdio.h>

#define debug(fmt, ...)	\
	do {		\
		printf(fmt, ##__VA_ARGS__);	\
	} while(0)

int main()
{
	debug("nihao\n");
	debug("nihao %d\n", 10);
	debug("%s %d\n", "nihao", 10);

	return 0;
}
