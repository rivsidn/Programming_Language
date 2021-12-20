#include <stdio.h>

int main()
{
	int arr[20] = {0};
	int *p1 = &arr[0];
	int *p2 = &arr[9];

	/* 输出 9，此处的长度单位是 sizeof(int)，而不是sizeof(char) */
	printf("%ld\n", (p2 - p1));

	return 0;
}

