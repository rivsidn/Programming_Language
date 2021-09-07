#include <stdio.h>

/* 函数指针的定义方法 */

int add(int a, int b)
{
	return a+b;
}
int sub(int a, int b)
{
	return a-b;
}

int main()
{
	int ret;
	int (*)(int,int) func = add;

	ret = func(1, 2);
	printf("%d\n", ret);

	return 0;
}
