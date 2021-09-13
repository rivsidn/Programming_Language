#include <stdio.h>


/* 结构体指针数组使用 */

struct TEST {
	int a;
	int b;
};

int main()
{
	//结构体指针数组
	struct TEST * t[10];
	struct TEST a;

	t[1] = &a;

	a.a = 10;
	a.b = 20; 

	printf("%d %d\n", t[1]->a, t[1]->b);

	return 0;
}
