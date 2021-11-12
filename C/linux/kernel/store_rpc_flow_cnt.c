#include <stdio.h>

int main()
{
	int mask = 2;

	while ((mask | (mask >> 1)) != mask)
		mask |= (mask >> 1);
	
	printf("%d\n", mask);

	return 0;
}
