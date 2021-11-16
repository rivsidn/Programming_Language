#include <stdio.h>

#define AA 10
#ifdef	AA
#undef 	AA
#define AA 20
#endif

int main()
{
	printf("%d\n", AA);

	return 0;
}
