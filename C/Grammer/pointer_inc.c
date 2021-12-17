#include <stdio.h>
#include <stdlib.h>

int main()
{
	void *vp = malloc(128);

	/* 空指针的偏移量为 1 字节 */
	printf("%p\n", vp);
	printf("%p\n", vp + 1);
	printf("%p\n", vp + 2);

	return 0;
}
