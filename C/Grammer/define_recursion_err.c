#define foo	(a,b)		//不加括号的时候会报错
#define bar(x)	lose(x)
#define lose(x)	(1 + (x))

int main()
{
	bar(foo);
}
