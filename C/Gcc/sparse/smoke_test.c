/* 还没弄明白怎么用，这个暂时搁置 */
#include <stdio.h>

#define __acquires(x) __attribute__((context(x,0,1)))
#define __releases(x) __attribute__((context(x,1,0)))

static void func(int x)
	__releases(x)
	__acquires(x)
{
	printf("%d\n", x);
}

int main(int argc, char *argv[])
{
	int x = 9;

	printf("%d\n", x);
	func(x);
	printf("%d\n", x);

	return 0;
}
