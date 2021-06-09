package main

import (
	"fmt"
	"time"
)

func f(from string) {
	for i := 0; i < 3; i++ {
		fmt.Println(from, ":", i)
	}
}

func main() {
	f("direct")

	/* 协程是用户态实现的，从内核来看是一个线程 */
	go f("goroutine")

	go func(msg string) {
		fmt.Println(msg)
	}("going")

	/* 如果不等待，就会直接退出 */
	time.Sleep(time.Second)
	fmt.Println("done")
}
