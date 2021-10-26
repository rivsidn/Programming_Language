#include <stdio.h>
#include <stdlib.h>

struct TEST {
	char *p0;
	char *p1;
	char *p2;
	char *p3;
	char *p4;
} g_test;

int main()
{
	int i, j;

	g_test.p0 = malloc(sizeof(char)*10);
	g_test.p1 = malloc(sizeof(char)*10);
	g_test.p2 = malloc(sizeof(char)*10);
	g_test.p3 = malloc(sizeof(char)*10);
	g_test.p4 = malloc(sizeof(char)*10);

	for (i = 0; i < 4; i++) {
		char *p = *((char **)&(g_test.p0) + i);
		for (j = 0; j < 10; j++) {
			p[j] = i*10 + j;
		}
	}
	for (i = 0; i < 4; i++) {
		char *p = *((char **)&(g_test.p0) + i);
		for (j = 0; j < 10; j++) {
			printf("%03d ", p[j]);
		}
		printf("\n");
	}

	//TODO: 理解这个例子
	printf("%d\n", (g_test.p2[9]));
	printf("%ld\n", &(g_test.p2[9]) - g_test.p2);
}
