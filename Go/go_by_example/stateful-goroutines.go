package main

import (
	"fmt"
	"math/rand"
	"sync/atomic"
	"time"
)

type readOp struct {
	key int
	resp chan int		//同步& 获取int作用
}
type writeOp struct {
	key int
	val int
	resp chan bool		//同步作用
}

func main() {
	var readOps uint64
	var writeOps uint64

	reads := make(chan readOp)
	writes := make(chan writeOp)

	/* 启动一个协程 */
	go func() {
		var state = make(map[int]int)
		for {
			select {
				case read := <-reads:
					read.resp <- state[read.key]
				case write := <-writes:
					state[write.key] = write.val
					write.resp <- true
			}
		}
	}()

	/* 启动100 个读协程 */
	for r := 0; r < 100; r++ {
		go func() {
			for {
				read := readOp{
					key : rand.Intn(5),
					resp : make(chan int)}
				reads <- read
				<-read.resp
				atomic.AddUint64(&readOps, 1)
				time.Sleep(time.Millisecond)
			}
		}()
	}

	/* 启动10 个写协程 */
	for w := 0; w < 10; w++ {
		go func() {
			for {
				write := writeOp{
					key : rand.Intn(5),
					val : rand.Intn(100),
					resp: make(chan bool)}
				writes <- write
				<-write.resp
				atomic.AddUint64(&writeOps, 1)
				time.Sleep(time.Millisecond)
			}
		}()
	}

	time.Sleep(time.Second)

	/* 获取读写次数 */
	readOpsFinal := atomic.LoadUint64(&readOps)
	fmt.Println("readOps:", readOpsFinal)
	writeOpsFinal := atomic.LoadUint64(&writeOps)
	fmt.Println("writeOps:", writeOpsFinal)
}
