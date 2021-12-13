#include <stdio.h>

int func(int a)
{
	if (a) {
		return 0;
	} else {
		return 1;
	}
}

int main()
{
	int ret;
	int a = 10;

	ret = func(a);
	printf("%d\n", ret);

	return 0;
}
