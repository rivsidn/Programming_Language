package main

import "fmt"

func main() {
	messages := make(chan string)

	select {
	case msg := <-messages:
		fmt.Println("received message", msg)
	default:
		fmt.Println("no message received")
	}
}
