package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
)

//文件名
const file string = "./test.txt"

func main() {
	//打开文件
	f, err := os.Open(file)
	if err != nil {
		fmt.Println(err)
		return
	}

	//读取文件内容(1)
	input := bufio.NewScanner(f)
	for input.Scan() {
		fmt.Println(input.Text())
	}
	//读取文件内容(2) data是字节切片
	data, err := ioutil.ReadFile(file)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(string(data))


	//写入文件，暂时没学会 :)

	//关闭文件描述符
	f.Close()
}
