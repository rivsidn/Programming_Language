//断言的用法，断言也就是通过当前的interface类型获取更高的权限
//1. 获取他的实体类型
//2. 获取其他的interface 类型(也就是获取其他方法)
package main

import (
	"fmt"
	"io"
	"os"
)

func f1() {
	var w io.Writer

	//1. 断言用法一，通过接口类型获取对应具体类型的值
	w = os.Stdout
	fmt.Printf("%T\n", w)		//打印interface 的动态类型

	f := w.(*os.File)		//此时w 的动态类型为(*os.File) 所以，将具体类型的值赋给f

	fmt.Fprintf(f, "abcdefg\n")
}

func f2() {
	var w io.Writer

	//2. 断言用法二，通过一个小的接口类型获取一个更大的接口类型
	w = os.Stdout
	rw := w.(io.ReadWriter)

	rw.Write([]byte("nihao\n"))
}

func main() {
	f1()
	f2()

	var w io.Writer

	w = os.Stdout
	if w,ok := w.(*os.File); ok {
		var wr io.ReadWriter		//if 内部，w 的值被覆盖了
		wr = w
		wr.Write([]byte("hahaha\n"))
	}

	var wr io.ReadWriter
	wr = w.(io.ReadWriter)
	wr.Write([]byte("hbhbhbhb\n")) }

