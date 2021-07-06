package main

import (
	"fmt"
	"time"
)

func main() {
	//获取当前时间
	start := time.Now()
	//休眠一段时间
	time.Sleep(2*time.Second)
	//获取时间间隔，结果是浮点型
	secs := time.Since(start).Seconds()

	fmt.Println(start, "\n", secs)
}
