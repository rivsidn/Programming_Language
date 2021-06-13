package main

import "fmt"

func main() {
	messages := make(chan string)

	/* 函数中必须是函数调用 */
	go func() {
		messages <- "ping"
	}()

	msg := <-messages
	fmt.Println(msg)
}
