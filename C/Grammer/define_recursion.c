/*
 * 代码编译不通过
 */
#include <stdio.h>

#define Add(a, b)	(10 + Add(a, b))

int main()
{
	printf("%d\n", Add(10, 20));

	return 0;
}

/*
 * 代码展开结果如下所示，为了防止递归，已经展开过一次的
 * 符号不会重复展开。
 */
/*
int main()
{
 printf("%d\n", (10 + Add(10, 20)));

 return 0;
}
*/

