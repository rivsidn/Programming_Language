#include <stdio.h>

int main()
{
	printf("%s\n", "f");
	printf("%*c%s\n", 00, ' ', "f");
	printf("%*c%s\n",  1, ' ', "f");
	printf("%*c%s\n", 10, ' ', "f");
	printf("%*c%s\n", 20, ' ', "f");
	printf("%*c%s\n", 30, ' ', "f");

	return 0;
}
