package main

import "fmt"

func main() {
	var p *int
	if p == nil {
		fmt.Println("p is null")
	} else {
		fmt.Println("p not null")
	}
}
