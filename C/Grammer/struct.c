
#include <stdio.h>

struct TEST {
	unsigned char a:2;
	unsigned char b:1;
	unsigned char c:1;
	unsigned char d:1;
	unsigned char e:1;
	unsigned char f:1;
	unsigned char g:1;
};

int main()
{
	struct TEST test;

	/* 此处只能设置小于2bit 的数大小 */
	test.a = 3;

	printf("test.a %d sizeof(test) %lu\n", test.a, sizeof(test));

	return 0;
}
