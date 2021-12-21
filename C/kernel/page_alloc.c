#include <stdio.h>

#define MAX_ORDER 10
#define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))

int main()
{
	int i;
	unsigned long mask = -1;
	unsigned long size = 1024;

	for (i = 0; i < MAX_ORDER; i++) {
		unsigned long bitmap_size;

		//构造free_area{}
		printf("%lx ", mask);
		mask += mask;
		printf("%lx %lx\n", mask, ~mask);
		/*
		 * ~mask = 2^(i+1) - 1;
		 *  mask = ~mask;
		 */
		size = (size + ~mask) & mask;
		bitmap_size = size >> i;	//位图是整个zone的位图
		bitmap_size = (bitmap_size + 7) >> 3;
		bitmap_size = LONG_ALIGN(bitmap_size);

		printf("i %d size %lu bitmap_size %lu\n", i, size, bitmap_size);
	}
}
