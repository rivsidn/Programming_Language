#include <stdio.h>

#if 0
#define stra		"string"
#define str(A, B) 	strl(A##B)

/*
 * 最终输出结果，"string..."
 */
int main()
{
	printf("%s\n", str(str, a));

	return 0;
}
#endif

#define AABB		"aabb"
#define CCDD		"ccdd"
#define AA		CC
#define BB		DD
#define COMBINE(X, Y)	X##Y

int main()
{
	/* 结合会直接将AA,BB 链接成 AABB，然后继续做宏转换 */
	printf("%s\n", COMBINE(AA, BB));
}
