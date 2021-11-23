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

struct list_head {
	struct list_head *next, *prev;
};
struct page_buffer {
	struct list_head list;
	unsigned long    l;
};
void func2(void)
{
	int i;
	struct page_buffer *t;
	struct page_buffer  a, b, c;
	a.l = 1;
	b.l = 2;
	c.l = 3;

	a.list.next = &(b.list);
	a.list.prev = &(c.list);
	b.list.next = &(c.list);
	b.list.prev = &(a.list);
	c.list.next = &(a.list);
	c.list.prev = &(b.list);

	t = &a;
	while (t) {
		printf("%ld\n", t->l);
		t = (struct page_buffer *)t->list.next;

		if (i++ > 10)
			break;
	}
}

int main()
{
#if 0
	func0();
	func1();
#endif
	func2();

	return 0;
}
