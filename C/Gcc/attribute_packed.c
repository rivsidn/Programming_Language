#include <stdio.h>

/* 占 8 个字节 */
struct AA {
	char a;
	int  b;
};

/* 占 5 个字节 */
struct BB {
	char a;
	int  b;
}__attribute__((packed));

int main()
{
	printf("%ld %ld\n", sizeof(struct AA), sizeof(struct BB));

	return 0;
}
