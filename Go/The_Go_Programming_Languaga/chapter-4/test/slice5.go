package main

import "fmt"

func appendTest(nums []int) []int {
	for i := 0; i < 30; i++ {
		nums = append(nums, i)
	}

	return nums
}

func main() {
	var nums []int

	/* 此处nums 不会更新，test 会是添加之后的值 */
	test := appendTest(nums)

	fmt.Println(nums)
	fmt.Println(test)
}
