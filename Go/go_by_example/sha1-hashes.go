package main

import (
	"crypto/sha1"
	"fmt"
)

func main() {
	s := "sha1 this string"

	h := sha1.New()

	/* TODO: 这里不知道是怎么实现的？ */
	/* 写入内容然后计算 */
	h.Write([]byte(s))

	/* 返回最终值 */
	bs := h.Sum(nil)

	fmt.Println(s)
	fmt.Printf("%x\n", bs)
}
