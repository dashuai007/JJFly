//
//  JAOP.cpp
//  JACCC
//
//  Created by xiazhongchong on 17/01/2018.
//  Copyright © 2018 JJFly. All rights reserved.
//
/*
 
 
 OOP面向对象编程系统
 对象意味着真实世界的实体，如笔，椅子，表等。面向对象编程是一种使用类和对象来设计程序的方法或范例。它通过提供一些简化了软件开发和维护概念：
 对象：任何具有状态和行为的实体都称为对象例如椅子，钢笔，桌子，键盘，自行车等。他可以是物理或逻辑的
 类：对象的集合称为类。它是一个逻辑实体
 继承：当一个对象获取父类对象的所有属性和行为，称为继承。它提供代码可重用性。它用于实现运行时多态性。
 多态：当一个任务通过不同方式执行时，即被称为多态性。
 在C++中我们使用函数重载和函数重写来实现多态
 抽象：隐藏内部细节和显示功能被称为抽象。使用抽象类和接口实现抽象
 封装：将代码和数据绑定在一起称为单个单元称为封装。
 
 OOP相对于面向过程编程语言的有点
 OOP是开发和维护变得更加容易，因为在面向过程的编程语言中，如果代码随着项目规模的增长而增长就不容易管理
 OOP提供数据隐藏，在面向过程的编程语言中，可以从任何地方访问全部数据
 OOP提供更有效地模拟真实事件的能力。如果我们使用面向对象编程语言，就可以提供真实世界里的问题的解决方案.
 
 C++编程中，this是一个引用类的当前实例的关键字。this关键字在C++中可以有3个主要用途。
 用于将当前对象作为参数传递给另个一方法
 用来引用当前类的实例变量
 用来声明索引器
 */
#include "JAOP.hpp"
#include <iostream>
class Student
{
public:
    int id;
    float salary;
    std::string name;
    void insert(int i, std::string n) {
        id = i;
        name = n;
    }
    void display () {
        std::cout << " show " << name << std::endl;
    }
};

class Employee {
public:
    int id;
    std::string name;
    float salary;
    Employee(int id, std::string name, float salary){
        this->id = id;
        this->name = name;
        this->salary = salary;
    }
    void display() {
        std::cout << id << " " << name << " " <<  salary << std::endl;
    }
};

int main (int argc, const char * argv[]) {
    
    Student stu1;
    stu1.id = 52;
    stu1.name = "John";
    stu1.salary = 9000;
    std::cout << stu1.id << std::endl;
    std::cout << stu1.name << std::endl;
    stu1.display();
    stu1.insert(31, "Abzeric");
    
    Employee e1 = Employee(101, "John", 19999);
    Employee e2 = Employee(102, "Abzeric", 299999);
    e1.display();
    e2.display();
    
    return 0;
}




