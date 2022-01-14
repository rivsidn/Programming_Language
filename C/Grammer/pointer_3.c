#include <stdio.h>
#include <string.h>

#define SIZE 10


void func(int *p[])
{
	memset(p, 0, sizeof(int *)*SIZE);
}

int main()
{
	int i;
	int *p[SIZE];
	int var[SIZE];

	for (i = 0; i < SIZE; i++) {
		var[i] = i + 10;
		p[i] = &(var[i]);
	}

	for (i = 0; i < SIZE; i++) {
		printf("%d\n", *p[i]);
	}

	func(p);

	for (i = 0; i < SIZE; i++) {
		printf("%d\n", p[i] ? *p[i] : 0);
	}

	return 0;
}
