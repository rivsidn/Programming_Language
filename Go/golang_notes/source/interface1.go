package main

import (
	"io"
	"os"
)

func main() {
	var w io.Writer

	w = os.Stdout

	//将string 强转成 []byte
	w.Write([]byte("nihao\n"))
}
