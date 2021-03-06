#include <stdio.h>

/*
 * 宏涉及三种用法：
 * 1. 字符串化(#)
 *    直接将内容转换成字符串，转换成字符串后数据不需要继续做宏展开
 * 2. 拼接(##)
 *    直接将内容拼接之后继续做宏展开
 * 3. 宏替换
 *    prescan处理，如下，将宏定义依次展开到最后.
 */
#define __stringify_1(x...)	#x
#define __stringify(x...)	__stringify_1(x)

#define bbb	ccc
#define bar	bbb
#define FOO	bar

int main()
{
	printf("%s\n", __stringify(FOO));
	printf("%s\n", __stringify_1(FOO));
}
