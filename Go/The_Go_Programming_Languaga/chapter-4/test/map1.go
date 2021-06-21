package main

import "fmt"

func main() {
//	ages := make(map[string]int)
	ages := map[string]int{}

	ages["alice"] = 31
	ages["charlie"] = 34

	fmt.Println(ages["alice"])
}

