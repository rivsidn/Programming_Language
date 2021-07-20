package main

import (
	"flag"
	"fmt"
)

//声明一个符合接口的类型
type celsiusFlag struct {
	celsius float64
}

func (f *celsiusFlag) String() string {
	return fmt.Sprintf("this is %f C", f.celsius)
}

func (f *celsiusFlag) Set(s string) error {
	var unit string
	var value float64

	fmt.Sscanf(s, "%f%s", &value, &unit)
	switch unit {
		case "C":
			f.celsius = value
			return nil
		case "F":
			f.celsius = value
			return nil
	}

	return fmt.Errorf("invalid temperature %q", s)
}

//创建注册函数
func CelsiusFlag(name string, value float64, usage string) *celsiusFlag {
	f := celsiusFlag{value}

	flag.CommandLine.Var(&f, name, usage)

	return &f
}

var temp = CelsiusFlag("temp", 20.0, "the temperature")

func main() {
	//再次调用的时候会更新temp的值
	flag.Parse()

	fmt.Println(temp.celsius)
	fmt.Println(temp)
}

