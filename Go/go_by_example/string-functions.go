package main

import (
	"fmt"
	s "strings"
)

var p = fmt.Println

func main() {
	p("Contains :", s.Contains("test", "es"))
}
