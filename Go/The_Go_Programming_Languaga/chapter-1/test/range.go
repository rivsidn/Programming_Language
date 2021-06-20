package main

import (
	"fmt"
)

func main() {
	s := []string{"aaa", "bbb", "ccc", "fadfa"}

	/* 循环次数等于切片数量 */
	for range s {
		fmt.Println("xxx")
	}
}

