#include <stdio.h>
#include <string.h>

/*
 * 循环中的变量，每次循环栈中的内存是相同的，
 * 每次都会重新执行初始化操作.
 */

#define BUFF_SIZE	16

int main() {
	int i;

	for (i = 0; i < 10; i++) {
#if 1
		char buff[BUFF_SIZE];
#else
		//默认每次都初始化
		char buff[BUFF_SIZE] = {0};
#endif
		printf("%d %p %s\n", i, buff, buff);
		strncpy(buff, "aaabbbcccddd", BUFF_SIZE);
	}

	return 0;
}
