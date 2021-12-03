#include <stdio.h>

/*
 * $ ./a.out 1>/dev/null 2>&1
 * 
 * 将标准输入和标准输出全部重定向到/dev/null 中
 */
int main()
{
	fprintf(stdout, "stdout...\n");
	fprintf(stderr, "stderr...\n");

	return 0;
}
