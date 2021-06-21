package main

import "fmt"

func main() {
	var runes []rune
	fmt.Printf("cap is %d\n", cap(runes))

	for _,r := range "hello, 世界" {
		runes = append(runes, r)
	}
	for _,r := range "hello, 世界" {
		runes = append(runes, r)
	}
	for _,r := range "hello, 世界" {
		runes = append(runes, r)
	}

	fmt.Printf("%q\n", runes)
	fmt.Printf("cap is %d\n", cap(runes))

	for i,_ := range runes {
		fmt.Println(runes[i])
	}
}
