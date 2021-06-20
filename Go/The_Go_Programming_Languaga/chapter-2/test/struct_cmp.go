package main

import "fmt"

type s1 struct {
	a int
	b int
}
type s2 struct {
	a int
	b int
}

func main() {
	/* 结构体初始化 */
	a := s1{a:10, b:20}
	b := s2{a:10, b:20}

	fmt.Println(a)
	fmt.Println(b)
}
