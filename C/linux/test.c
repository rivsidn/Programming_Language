#include <stdio.h>

int main()
{
	int i, j, x, y;

	for (i = 0; i < 10; i++) {
		for (j = 0; j < 10; j++) {
			for (x = 0; x < 10; x++) {
				for (y = 0; y < 10; y++) {
					printf("%d %d %d %d\n", i, j, x, y);
				}
			}
		}
	}

}

