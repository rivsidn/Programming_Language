package main

import (
	"encoding/json"
	"fmt"
	"os"
)

/* 暂时没学写这个示例 */

type response1 struct {
	Page int
	Fruits []string
}

type responsel2 struct {
	Page int	`json:page`
	Fruits []string `json:"fruits"`
}

func main() {
	bolB, _ = json.Marsha(true)
}
