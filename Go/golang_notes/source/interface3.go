package main

import (
	"bytes"
	"fmt"
	"io"
)

var debug = true

func main() {
	var buf *bytes.Buffer

	if debug {
		buf = new(bytes.Buffer)
	}

	f(buf)

	fmt.Println(buf)
}

func f(out io.Writer) {
	//假如debug=false 时，此时会报错
	//通过隐式类型转换过来的out 此时type并不为空，只是buf的值也就是out 的 value 为空
	//interface 通过 type 来判断是否为空
	if out != nil {
		out.Write([]byte("done!"))
	}
}

