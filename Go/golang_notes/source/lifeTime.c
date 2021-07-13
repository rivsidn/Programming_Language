#include <stdio.h>


int main()
{
	int i;
	for (i = 0; i < 10; i++) {
		int b = 10;

		printf("%p\n", &b);		//每次打印的地址都相同
	}

	return 0;
}
