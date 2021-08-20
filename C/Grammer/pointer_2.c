#include <stdio.h>

#define BUFF_SIZE	10

int main() {
	int i;
	char buff[BUFF_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

	/* 下边两种表达方式相同，修改数组的第一个元素 */
	*(buff) = 11;
//	*(buff + 0) = 11;

	for (i = 0; i < BUFF_SIZE; i++) {
		printf("%d \n", buff[i]);
	}

	return 0;
}

