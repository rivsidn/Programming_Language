#include <stdio.h>
#include <string.h>

#define NO_CMDLINE_MAP (~0U)

int main()
{
	int i;
	char str[10] = {0};

	memset(str, 0xff, sizeof(str));

	/*
	 * TODO: 抽时间理解一下这里的输出，为什么不加(unsigned char)
	 * 的时候输出 ffffffff.
	 */
	for(i = 0; i < 12; i++) {
		printf("%x\n", (unsigned char)str[i]);
	}

	return 0;
}
