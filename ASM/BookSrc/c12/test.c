#include <stdio.h>

void fun(char *arr, int size) {
	int i, j;

	for (i = size-1; i > 0; --i) {
		for (j = 0; j < i; ++j) {
			if (arr[j] > arr[j+1]) {
				char tmp = arr[j];
				arr[j] = arr[j+1];
				arr[j+1] = tmp;
			}
		}
	}
}

int main() {
	int i;
	char arr[] = {'a', 'b', 's', 'd', 'e'};

	fun(arr, 5);

	for (i = 0; i < 5; ++i) {
		printf("%c \n", arr[i]);
	}
}
