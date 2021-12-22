#include <stdio.h>

int main()
{
	int i, ret;
	char buff[6] = {0};

	i = 0;
	ret = 0;
	while (i++ < 20) {
		ret += snprintf(buff+ret, sizeof(buff)-ret-1, "%d", i);
		printf("%d\n", ret);
	}

	printf("%s\n", buff);

	printf("debug\n");

	return 0;
}
