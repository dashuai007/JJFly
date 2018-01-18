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
 
 在C++static是属于类而不是实例的关键字或修饰符。因此不需要实例来访问静态成员。在C++中，static可以使字段，方法，构造函数，类，属性，操作符和事件
 C++static关键字的优点
 内存效率：现在我们不需要创建实例来访问静态成员，因此它节省了内存。此外，它属于一种类型，所以每次创建实例时，不会再去获取内存。
 C++静态字段
 使用static关键字声明字段称为静态字段。它不像每次创建对象时都要获取内存的实例字段，在内存中值创建一个静态字段的副本。它被共享给所有的对象。
 它用于引用所有对象的公共属性，如：Account类中的利率==
 
 在C++中，类和结构体struct是用于创建类的实例的蓝图，结构体可用于轻量级对象，如矩形，颜色，点等。
 与类不同，C++中的结构体是值类型而不是引用类型。如果想在创建结构体之后不想修改的数据，结构体是很有用的
 
 C++中的枚举是一种包含固定常量的数据类型
 C++中的枚举是一种包含固定的常量集合的类
 C++中枚举注意事项
 枚举提高了类型安全性；枚举可以很容易地在switch语句中使用；枚举可以遍历；枚举可以有字段，构造函数和方法；枚举可以实现许多借口，但不能扩展任何类，因为它在内部扩展Enumeration类
 
 C++ 友元函数
 如果一个函数在C++中定义为一个友元（使用friend作为修饰符）函数，那么可以使用该函数访问类的protected和private数据
 通过使用friend关键字，编译器知道给定的函数是一个友元函数，为了访问数据，友元函数的声明应该在一关键字friend开头的类的主体内部进行
 
 在C++中，继承是一个对象自动获取其父对象的所有属性和行为的过程，在实例方式中，您可以重用扩展和修改在其他类中定义的属性和行为
 
 C++继承的优点
 代码可以重用性；现在可以重用父类的类称为派生类，其成员被继承的类称为基类。派生类是基类的子类
 
 当一个类继承一个被另一个类继承的类时，它被称为C++中的多级继承。继承是传递的，所以最后的派生类获取所有其基类的所有成员
 
 C++中，聚合是一个进程，一个类将另一个类定义为实体引用（一个类作为另一个类的成员）。这是另一种重用类的方法。它是一种表示HAS-A关系的关联形式
 
 多态Polymorphism就是poly+morphs的组合，其意味着多种形式。封装、继承、多态
 C++中有两种类型的多态：
 编译时多态：通过函数重载和操作符重载来实现，这也称为静态绑定或早起绑定
 运行时多态性：通过方法覆盖来实现，也称为动态绑定或后期绑定
 
 如果创建两个或多个成员函数具有相同的名称，但函数的数量或类型不同，则称为C++重载。在C++中，我么可以重载：方法、构造函数、索引属性
 这是因为这些成员只有参数
 C++中的重载类型有：函数重载、运算符重载
 C++函数重载
 在C++中，具有两个或更多个具有相同名称但参数不同的函数称为参数重载
 函数重载增加了程序的可读性，不需要为同一个函数操作功能使用不同的名称。
 C++函数重载示例
 
 C++虚函数是基类中的一个成员函数，您可以在派生类中重新定义它。它声明使用virtual关键字。它用于高速编译器对函数执行动态链接或后期绑定
 后期绑定或动态链接
 在后期绑定函数调用在运行时被解决。因此，编译器在运行时确定对象的类型，然后绑定函数调用
 
 抽象类时在C++中实现抽象的方式。C++中的抽象是隐藏内部细节和仅显示功能的过程。抽象可以通过两个方式实现：抽象类、接口
 抽象类和接口都可以有抽象所需的抽象方法
 
 C++抽象类
 在C++类中，通过将其函数中的至少一个声明为纯虚函数，使其变得抽象。通过在其声明中放置“=0”来指定纯虚函数。它的实现必须由派生类提供。
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

class Account {
public:
    int accno;
    std::string name;
    static float rateOfInterest;
    static int count;
    Account(int accno, std::string name){
        this->accno = accno;
        this->name = name;
        count++;
    }
    void display(){
        std::cout << accno << "<<name<<" << rateOfInterest << std::endl;
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

struct Rectangle {
    int width, height;
    Rectangle(int w, int h){
        width = w;
        height = h;
    }
    void areaOfRectangle() {
        std::cout << "Area of Rectangle rec=Rectangle" << (width * height);
    }
};

enum Week {
    Monday,Tuesday,Wednesday,Thursday,Fraiday,Saturday,Sunday
};

class Box {
private:
    int length;
public:
    Box():length(0){};
    friend int printLength(Box);
};
int printLength(Box b) {
    b.length += 10;
    return b.length;
};

class NewAccount {
public:
    float salary = 6000;
};

class Programmer: public NewAccount {
public:
    float bouns = 5000;
};
//单继承
class Animal {
public:
    void eat() {
        std::cout << "Eating ..." << std::endl;
    }
};

class Dog: public Animal {
public:
    void bark() {
        std::cout << "Barking..." << std::endl;
    }
};

class BabyDog: public Dog {
public:
    void weep() {
        std::cout << "Weeping...";
    }
};

class Address {
public:
    std::string addressLine, city, state;
    Address(std::string addressline, std::string city, std::string state) {
        this->addressLine = addressLine;
        this->city = city;
        this->state = state;
    }
};

class ShopEmployee {
private:
    Address *address;
public:
    int id;
    std::string name;
    ShopEmployee(int id, std::string name, Address *address) {
        this->id = id;
        this->name = name;
        this->address = address;
    }
    void display() {
        std::cout << id << " " << address->addressLine << " " << address->city<< " " << address->state << std::endl;
    }
};

class Cal {
public:
    static int add(int a, int b){
        return a + b;
    }
    static int add(int a, int b, int c){
        return a + b + c;
    }
};

class AClass {
public:
    virtual void display() {
        std::cout << "Base class is invoked" << std::endl;
    }
};
class BClass: public AClass {
public:
    void display() {
        std::cout << "Derived Class is invoked" << std::endl;
    }
};

class Shape {
public:
    virtual void draw()=0;
};

class RectangleClass : Shape {
public:
    void draw() {
        std::cout << "drawing rectangle..." << std::endl;
    }
};

class CircleClass : Shape {
public:
    void draw() {
        std::cout << "drawing circle ..." << std::endl;
    }
};



float Account::rateOfInterest = 6.5;
int Account::count = 0;
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
    
    Account a1 = Account(201, "Sanjay");
    Account a2 = Account(202, "Calf");
    a1.display();
    a2.display();
    std::cout << "Total Objects are:" << Account::count;
    //result is 2
    
    struct Rectangle rect = Rectangle(4, 6);
    rect.areaOfRectangle();//24
    
    Cal cal;
    std::cout << cal.add(10, 20) << std::endl;
    std::cout << cal.add(12, 20, 14) << std::endl;
    
    Box box;
    std::cout << "length of box:" << printLength(box) << std::endl;
    
    Programmer p1;
    std::cout << "Salary is " << p1.salary << std::endl;
    std::cout << "Bonus is " << p1.bouns << std::endl;
    
    Dog d1;
    d1.eat();
    d1.bark();
    
    BabyDog baby;
    baby.eat();
    baby.bark();
    baby.weep();
    
    AClass *aClass;
    BClass bClass;
    aClass = &bClass;
    aClass->display();
    
    RectangleClass rectClass;
    CircleClass circleClass;
    rectClass.draw();
    circleClass.draw();
    return 0;
}




