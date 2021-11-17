#include <stdio.h>


#define AA 10

/* 这里直接展开 aa = 10 */
static int aa = AA;

#undef AA
#define AA 20

int main()
{
	/* 此处输出 10 */
	printf("%d\n", aa);

	return 0;
}
