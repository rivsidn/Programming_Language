package main

import (
	"fmt"
)

func main() {
	var a = [...]int{1, 2, 3}
	var b = &a

	fmt.Println(a[0], a[1])
	fmt.Println(b[0], b[1])

	for i, v := range b {
		fmt.Println(i, v)
	}

	for i := range a {
		fmt.Printf("a[%d]: %d\n", i, a[i])
	}

	/* 遍历了三次 */
	var times [3][0]int
	for range times {
		fmt.Println("hello")
	}
}
