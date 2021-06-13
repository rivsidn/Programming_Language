package main

import (
	"fmt"
	"time"
)

/*
	创建多个3 个协程，通过 jobs 分发任务，通过 results 搜集结果
 */
func worker(id int, jobs <-chan int, results chan<-int) {
	for j := range jobs {
		fmt.Println("worker", id, "started job", j)
		time.Sleep(time.Second)
		fmt.Println("worker", id, "finished job", j)
		results <- j*2
	}
}

func main() {
	const numJobs = 5
	jobs := make(chan int, numJobs)
	results := make(chan int, numJobs)

	for w := 1; w <= 3; w++ {
		go worker(w, jobs, results)
	}

	for j:= 1; j <= numJobs; j++ {
		jobs <- j
	}
	close(jobs)

	/* 搜集结果，确保协程结束 */
	for a := 1; a <= numJobs; a++ {
		<-results
	}
}

