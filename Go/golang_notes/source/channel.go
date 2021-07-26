package main

import (
	"fmt"
)

//channel 关闭之后，main 之后会一直获取到int 的 0 值


func fun(c chan int) {
	for i:=0; i<100; i++ {
		c<-i
	}
	//注释调close(c) 的时候，由于fun() 执行结束之后，只有main
	//阻塞在哪里，程序检测到没有所有的程序都休眠了，会报错
//	close(c)
}

func main() {
	c := make(chan int)

	go fun(c)
	for {
		fmt.Println(<-c)
	}

	fmt.Println(<-c)
}


