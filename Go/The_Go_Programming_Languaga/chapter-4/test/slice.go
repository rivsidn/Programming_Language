package main

import "fmt"

func main() {
	var months = [...]string {
		1:"1yue",
		2:"2yue",
		3:"3yue",
		4:"4yue",
		5:"5yue",
		6:"6yue",
		7:"7yue",
		8:"8yue",
		9:"9yue",
		10:"10yue",
		11:"11yue",
		12:"12yue",
	}

	Q2 := months[4:7]
	summer := months[6:9]

	fmt.Printf("Q2: %d\n", cap(Q2))
	fmt.Println(Q2)
	fmt.Printf("summer: %d\n", cap(summer))
	fmt.Println(summer)
	fmt.Println(summer[0])
	summer[0] = "22yue"
	fmt.Println(summer)

	fmt.Println(months)
}
