#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ROW_SIZE	9
#define COL_SIZE	4

/*
 * 数组指针使用。
 *
 * 1.申请9行*4列大小的内存
 * 2.通过长度为4的数组指针访问该部分内存
 * 3.第一行开始，间隔一行，将数据设置为 1
 * 4.输出内存中的内容
 */

int main() {
	int i, j;
	char *p = malloc(COL_SIZE*ROW_SIZE);
	memset(p, 0, COL_SIZE*ROW_SIZE);

	j = 0;
	char (*pa)[COL_SIZE] = (char (*)[COL_SIZE])p;
	for (i = 0; i < ROW_SIZE; i++) {
		if (i%2 == 0)
			j = 0;
		for (; j < COL_SIZE; j++) {
			(*pa)[j] = 1;
		}
		pa++;
	} 

	for (i = 0; i < COL_SIZE*ROW_SIZE; i++) {
		if (i != 0 && i%COL_SIZE == 0)
			printf("\n");
		printf("%d ", p[i]);
	}
	printf("\n");

	return 0;
}

