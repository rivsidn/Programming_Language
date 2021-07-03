package main

//import "fmt"
import (
	"io"
	"os"
)

func main() {
	var w io.Writer

	w = os.Stdout
	w.Write([]byte("nihao\n"))
}
