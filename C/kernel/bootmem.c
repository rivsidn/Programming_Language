#include <stdio.h>

#define PAGE_SHIFT	12				//页面偏移量
#define PAGE_SIZE	(1UL << PAGE_SHIFT)		//页面大小(1<<12) 4K
#define PAGE_MASK	(~(PAGE_SIZE-1))		//0xfffff000

int main()
{
	unsigned long pages = 100000;
	unsigned long mapsize;

	mapsize = (pages+7)/8;
	printf("%lu\n", mapsize);
	mapsize = (mapsize + ~PAGE_MASK) & PAGE_MASK;
	mapsize >>= PAGE_SHIFT;

	printf("%lu\n", mapsize);

	return 0;
}
