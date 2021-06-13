package main

import (
	"fmt"
	"time"
)

func main() {
	/* 每多久出发一次 */
	ticker := time.NewTicker(500*time.Millisecond)
	done := make(chan bool)

	go func() {
		for {
			select {
			case <-done:
				return
			case t := <-ticker.C:
				fmt.Println("Tick at", t)
			}
		}
	}()

	/* 休眠多长时间 */
	time.Sleep(1600*time.Millisecond)
	/* 停止ticker */
	ticker.Stop()
	/* 协程结束 */
	done <- true
	fmt.Println("Ticker stopped")
}
