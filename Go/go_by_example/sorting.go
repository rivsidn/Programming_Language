package main

import (
	"fmt"
	"sort"
)

func main() {
	strs := []string{"c", "a", "b"}
	sort.Strings(strs)
	fmt.Println("Strings:", strs)

	/* 默认是从低到高排序 */
	ints := []int{7, 2, 4}
	sort.Ints(ints)
	fmt.Println("Ints:   ", ints)

	/* 测试是否已经排好序 */
	s := sort.IntsAreSorted(ints)
	fmt.Println("Sorted: ", s)
}
