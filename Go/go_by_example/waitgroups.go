package main

import (
	"fmt"
	"sync"
	"time"
)

func worker(id int, wg *sync.WaitGroup) {
	/* 结束的时候发出通知 */
	defer wg.Done()

	fmt.Printf("Worker %d starting\n", id)

	time.Sleep(time.Second)
	fmt.Printf("Worker %d done\n", id)
}

func main() {
	var wg sync.WaitGroup

	for i := 1; i <= 5; i++ {
		/* 增加需要等待的个数 */
		wg.Add(1)
		go worker(i, &wg)
	}

	/* 等待直到最终结束 */
	wg.Wait()
}

