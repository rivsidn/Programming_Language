package main

import (
	"fmt"
)

/*
var a int = b
var b int = a				//循环引用会导致编译出错
*/

func f() (int, int) {
	return 1, 2
}

func main() {
	var aa int
/*
	var aa int			//同一词法域不能定义两个相同的变量名
 */
	{
		var aa int = 10		//通过{} 明确定义了一个新的词法域，在该词法域内访问不到外部变量aa
		fmt.Println(aa)
	}
	fmt.Println(aa)

	fmt.Println("---------------------")
	var bb int = 10
	{
		var bb int = bb		//当bb出现在赋值右边时会访问外层的变量
		fmt.Println(bb)		//10
	}
	fmt.Println(bb)			//10
	fmt.Println("---------------------")
	//for() {} 隐式词法域
	//for 初始化的时候创建了一个隐式词法域
	for i:= 0; i < 10; i++ {
		var i int = 10
		fmt.Println(i)
	}


	//if{} else if{} else
	fmt.Println("---------------------")
	if i,j := f(); i != 0{
		fmt.Println(i, j)
	}
	/*
	fmt.Println(i, j)		//i,j 未定义
	*/

	//TODO: if(){} elseif(){}else{}  switch(){case} 的词法域暂时没写，之后遇到补充

	//switch() {}
}
