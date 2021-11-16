#include <stdio.h>

/*
 * #ifdef 和 #define 之间是存在先后顺序的.
 */

#ifdef TEST
#define AA	10
#else
#define AA	20
#endif

#define TEST

int main()
{
	printf("%d\n", AA);
}
