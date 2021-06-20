package main

import "fmt"

const (
	_ = (1000 * iota)
	a
	b
	c
)

func main() {
	fmt.Println(a, b, c)
}
