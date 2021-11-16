#include <stdio.h>

/* # 和 define 之间可以有空格  */
#define A 10

# define B 10

int main()
{
	printf("%d\n", A);
	printf("%d\n", B);

	return 0;
}
