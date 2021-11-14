/*
 * 头文件的包含关系，先定义的是 headAA.h 中的，后定义的是
 * headB.h 中的。
 * 编译过程中会包warning，但是最终生成的可执行文件会替换成
 * headB.h 中的定义。
 */
#include <stdio.h>

#include "headA.h"
#include "headB.h"

int main()
{
	int a = 10;
	int b = 10;

	printf("%d\n", add(a, b));

	return 0;
}
