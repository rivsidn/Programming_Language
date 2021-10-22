/*
 * __builtin_return_address(0) 返回函数的返回地址。
 */
#include <stdio.h>

int func1()
{
	unsigned long *p = __builtin_return_address(0);
	printf("%s %p\n", __func__, p);
}

int func0()
{
	unsigned long *p = __builtin_return_address(0);
	printf("%s %p\n", __func__, p);

	func1();
}

int main()
{
	func0();

	return 0;
}
