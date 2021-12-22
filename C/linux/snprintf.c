#include <stdio.h>

int main()
{
	int ret;
	char buff[6] = {0};

	/* 可以写入的实际有效的内容是 sizeof(buff)-1，snprintf() 中的大小为 sizeof(buff) */
	ret = snprintf(buff, sizeof(buff), "12345678");
	printf("%d %s %ld\n", ret, buff, sizeof(buff));

	return 0;
}
