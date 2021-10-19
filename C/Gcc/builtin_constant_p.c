/*
 * gcc 内建函数 __builtin_constant_p() 的使用
 */
#include <stdio.h>

int main()
{
	if (__builtin_constant_p(NULL)) {
		printf("null is constant\n");
	} else {
		printf("null not constant\n");
	}

	return 0;
}
