#include <stdio.h>
#include <stdlib.h>

int main() {
	int ret;

	ret = atoi("123 dafa");
	printf("%d\n", ret);

	ret = atoi("123dafa");
	printf("%d\n", ret);

	return 0;
}
