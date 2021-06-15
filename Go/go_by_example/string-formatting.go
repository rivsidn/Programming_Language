package main

import (
	"fmt"
	"os"
)

/* 这部分暂时不学习，暂时用不到 */
type point struct {
	x, y int
}

func main() {
	p := point{1, 2}
	fmt.Printf("%v\n", p)

	fmt.Printf("%+v\n", p)

	fmt.Fprintf(os.Stderr, "an %s\n", "error")
}
