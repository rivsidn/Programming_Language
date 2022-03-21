#!/usr/bin/python3

class Person():
    def __init__(self, fname, lname):
        self.firstname = fname
        self.lastname = lname

    def printname(self):
        print(self.firstname, self.lastname)


class Student(Person):
    pass

stu = Student("Bill", "Gates")

stu.printname()
