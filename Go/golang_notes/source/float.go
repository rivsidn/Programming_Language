package main

import (
	"fmt"
)

func main() {
	var z float64

	fmt.Println(z, -z, 1/z, -1/z, z/z)	//0 -0 +Inf -Inf NaN

	/*
	var b int32
	fmt.Println(b, -b, 1/b, -1/b, b/b)	//只有浮点型才支持正负无穷等
	*/
}
