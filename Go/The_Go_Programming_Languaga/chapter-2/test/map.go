package main

import "fmt"

func main() {
	//只是声明了一个map类型的变量，但是没有创建引用任何hash表
	var tt map[string]int

	//即使没有创建，也可以访问，访问结果都是 0
	fmt.Println(tt["bbb"])

	v, ok := tt["ccc"]
	fmt.Println(v, ok)
	v = tt["ddd"]
	fmt.Println(v)

	ages := make(map[string]int)

	tt = ages
	tt["aaa"] = 10

	fmt.Println(tt["aaa"])
}
