package main

import "fmt"

func intSeq() func() int {
	i := 0

	/*
	 * 内部函数总是可以访问其所在外部函数声明的参数和变量，
	 * 即使是外部函数被返回之后.
	 */
	return func() int {
		i++
		return i
	}
}

func main() {
	nextInt := intSeq()

	fmt.Println(nextInt())
	fmt.Println(nextInt())
	fmt.Println(nextInt())

	newnextInt := intSeq()
	fmt.Println(newnextInt())
}

