package main

import (
	"fmt"
	"sync"
	"sync/atomic"
)

func main() {
	var ops uint64
	var opsBak uint64
	var wg sync.WaitGroup

	for i := 0; i < 50; i++ {
		wg.Add(1)
		go func() {
			for c := 0; c < 1000; c++ {
				atomic.AddUint64(&ops, 1)
				/* 通过这种方式递增最终结果不固定 */
				opsBak += 1;
			}
			wg.Done()
		}()
	}

	wg.Wait()
	fmt.Println("ops", ops)
	fmt.Println("opsBak", opsBak)
}

