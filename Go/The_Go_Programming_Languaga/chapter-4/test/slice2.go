package main

import "fmt"

func main() {
	var z []int
	var x []int

	x = append(x, 1)
	x = append(x, 2)
	x = append(x, 3)
	x = append(x, 4)
	x = append(x, 5)

/*
	//此时改变x 的值，z 的值也会跟着改变
	z = x
	x[2] = 10
	fmt.Println(x)
	fmt.Println(z)

	fmt.Println("--------")

	//此时还是会跟着改变，但是x 的长度没增加
	z = append(z, 6)
	x[3] = 100
	fmt.Println(x)
	fmt.Println(z)
*/

	//copy 按照最小的来，此时的z 为空，所以copy 0个
	copy(z, x)
	fmt.Println(x)
	fmt.Println(z)	//此时输出z 为空
}
