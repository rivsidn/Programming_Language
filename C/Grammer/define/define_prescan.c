/*
 * 下边的代码预处理的时候报错，说明还是先处理 SINGLE()，
 * 不会先处理 AA，依次向后处理.
 */
#include <stdio.h>

#define SINGLE(X, Y, Z)	(X + Y + Z)
#define AA		a,b,z

int main()
{
	SINGLE(AA);

	return 0;
}
