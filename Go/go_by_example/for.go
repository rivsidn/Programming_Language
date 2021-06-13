package main

import "fmt"

func main() {
	//只有一个表示判断
	i := 1
	for i < 3 {
		fmt.Println(i)
		i = i + 1
	}

	for j := 7; j <= 9; j++ {
		fmt.Println(j)
	}

	//无限循环
	for {
		fmt.Println("loop")
		break;
	}

	for n := 0; n <= 5; n++ {
		if n%2 == 0 {
			continue
		}
		fmt.Println(n)
	}
}

