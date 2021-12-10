#include <stdio.h>

void func(void)
{
	int i = 0;

next:
	printf("%d\n", i++);

	if (i < 10) {
		goto next;
	}

	return;
}

int main()
{
	func();

	return 0;
}
