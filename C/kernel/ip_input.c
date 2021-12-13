#include <stdio.h>

int ip_rcv(int *a, int *b, int *c, int *d)
{
	*a = 0;
}

int main()
{
	int a, b, c, d;

	a = 1;
	b = 2;
	c = 3;
	d = 4;

	ip_rcv(&a, &b, &c, &d);

	printf("%d %d %d %d\n", a, b, c, d);

	return 0;
}
