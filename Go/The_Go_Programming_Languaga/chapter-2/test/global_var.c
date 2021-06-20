#include <stdio.h>

int a = 10;
int g = a;	//此时不可以初始化，会报错

int main()
{
	printf("%d\n", g);
}
