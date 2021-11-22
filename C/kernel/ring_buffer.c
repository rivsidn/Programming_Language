#include <stdio.h>

struct TEST {
	char	a;
	int	b;
	int	c;
};

#define offsetof(TYPE, MEMBER) ((unsigned long) &((TYPE *)0)->MEMBER)

void func0(void)
{
	printf("%lu\n", offsetof(struct TEST, a));
	printf("%lu\n", offsetof(struct TEST, b));
	printf("%lu\n", offsetof(struct TEST, c));
}

void func1(void)
{
	int a = 8;
	switch (a) {
		/* switch...case 中还可以这么用 */
		case 0 ... 5:
			printf("case 0 %d\n", a);
			break;
		case 7 ... 10:
			printf("case 1 %d\n", a);
			break;
		default:
			printf("default 1 %d\n", a);
			break;
	}
}

int main()
{
	func0();
	func1();

	return 0;
}
