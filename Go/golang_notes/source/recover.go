package main

import (
	"errors"
	"fmt"
)

//revocer() 函数
//将发生异常的函数正常返回
func f() (i int, err error) {
	i = 10
	defer func() {
		if p := recover(); p != nil {
			err = fmt.Errorf("internal error: %v", p)
		}
	}()

	panic("f")

	return 1, errors.New("test")
}

func main() {
	i, err := f()

	fmt.Println(i, err)
}
