#include <stdio.h>

/*
 * 此处宏定义的顺序与最终输出的结果无关。
 * 可以理解成，程序预处理的时候会生成一个符号之间的
 * 有向图，根据图来生成最终的预处理结果。
 * AA --> BB --> 100
 *
 * 所以最终会将AA 转换成 100
 *
 * 此处先这样理解，不一定对，有确切结论之后再更新。
 */
#define BB 100
#define AA BB

int main()
{
	printf("%d\n", AA);
}