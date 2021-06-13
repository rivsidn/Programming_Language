/*
 * 运行 go mod tidy 之前需要先执行:
 * export GOPROXY=https://goproxy.cn
 */
package main

import "fmt"
import "rsc.io/quote"

func main() {
	fmt.Println(quote.Go())
}
