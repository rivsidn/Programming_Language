package main

import (
	"fmt"
)

type Employee struct {
	ID	int
	Name	string
	Salary	int
}

//当返回值是 Employee 时候，实际返回的是一个副本，所以此时如果没有一个变量来保存
//这个副本，是不能赋值的
func createEmployee(e *Employee) Employee {
	return *e
}

func main() {
	var e Employee = Employee{
		0, "jimmy", 100,
	}
	/*
	createEmployee(&e).Salary = 1000	//这中方式分配会导致编译不通过
	*/

	e1 := createEmployee(&e)
	e1.Salary = 1000

	fmt.Println(e, e1)
}
