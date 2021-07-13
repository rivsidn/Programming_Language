package main

import "fmt"

func main() {
	var a1 complex128 = 1 + 1i
	var b1 complex128 = 1 + 1i
	fmt.Println(a1 * b1)

	fmt.Println("------------------")
	var a2 complex128 = 1.1i
	var b2 complex128 = 1.1i
	fmt.Println(a2 * b2)
}
