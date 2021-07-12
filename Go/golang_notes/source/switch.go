package main

import (
	"fmt"
)

func main() {
	switch "aa" {
		case "aa":
			fmt.Println("aa")
			fallthrough
		case "bb":
			fmt.Println("bb")
		default:
			fmt.Println("cc")
	}

	return
}
