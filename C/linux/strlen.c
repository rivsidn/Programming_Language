#include <stdio.h>
#include <string.h>

ssize_t __attribute__((noinline)) my_strlen(const char *s)
{
	return strlen(s);
}

int main(int argc, char *argv[])
{
	int ret = my_strlen("TEST");

	printf("%d\n", ret);

	return 0;
}
