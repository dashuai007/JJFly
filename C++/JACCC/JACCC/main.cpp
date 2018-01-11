//
//  main.cpp
//  JACCC
//
//  Created by xiazhongchong on 09/01/2018.
//  Copyright © 2018 JJFly. All rights reserved.
//


/**
 <#Description#>

 
 */
#include <iostream>//用于定义cout，cin和cerr对象，分别对应于标准输出流，标准输入流和标准错误流
#include <iomanip>//声明对执行格式化I/O的服务 如：setprecision 和 setw
#include <fstream>//用于声明用户控制文件处理的服务
//易百教程
//http://www.yiibai.com/cplusplus/
/**
 C++
 是一种通用的，区分代销写的自由格式编程语言，支持面向对象，过程和通用编程。C++是一种中级语言，因为它包含高级语言和低级语言特性
C++支持面向对象编程，主要支持：继承、多态性、封装、抽象

C++的标准库
C++编程分为三个部分： 1、核心库包括数据类型、变量和文字等
                   2、标准库包括操作字符串、文件等的一组函数
                   3、标准模板库（STL）包括操纵数据结构的一组方法
 
 C++的使用
 1、窗口应用程序
 2、客户端服务器应用程序
 3、设备驱动程序
 4、嵌入式固件
 
 C++面向对象的编程语言。功能如下：
 简单：他提供了结构化方法，将问题分解成几个小部分、丰富的库函数、数据类型
 机器独立或可移植：可在许多语言中执行、但可能有一点点或没有变化。但不是平台无关的
 中级编程语言：开发系统应用程序，如内核、启动程序等。他还支持高级语言的特性
 结构化编程语言：可以使用函数将程序分解为多个小部分。很容易理解和修改
 丰富的程序库：提供很多内置函数
 内存管理：动态内存分配的特性 free()函数随时市房分配的内存
 速度快：编译和执行时间都非常快
 指针：可以通过使用指针直接与内存交互。我们可以使用内存，结构，函数，数组等指针
 递归：可以调用函数内函数
 可扩展：可以比较容易地采用新的功能
 面向对象：OOP使开发和维护变得更容易，因为在面向过程的编程语言中，如果随着项目规模的增长而增长，就不容易管理了
 基于编译器：C++是一种基于编译器的编程语言，意思是没有贬义就没有C++程序可移植性，首先，我们需要使用编译器贬义程序，然后才能执行这个编译后的程序
 
 C与C++的区别
 C语言程序风格编程                          C++是多范式。支撑程序和面向对象
 C语言中的数据的安全性比较低                  C++中可以对类成员使用修饰符，以便其对外部用户不可访问
 C语言遵循自上而下的方法                      C++遵循自下而上的方法
 C语言不支持函数重载                         C++支持函数重载
 C语言结构中不能使用函数                      C++可以结构中使用函数
 C语言不支持引用变量                         C++ 支持引用变量
 C语言中scanf printf                       C++使用cin和count执行输入和输出操作
 C语言中操作符不可重载                        C++中操作符重载是可以的
 C语言程序分为程序和模块                       C++程序分为函数和类
 C语言不提供命名空间和功能                     C++支持命名空间的特性
 C语言中异常处理不容易，它必须使用其他函数执行     C++使用Try 和 Catch块提供异常处理
 
 C++基础输入输出（cin,cout,end）
 
 C++中的I/O操作使用流概念。流是字节或数据流的序列。它能使有效提高性能。如果字节从主存储器流向设备，如：打印机，显示屏或网络连接等设备流向等设备流向主存储器，则称为输出操作
 如果字节从打印机显示屏或网络连接设备流向主存储器，则称为输入操作
 <iostream>它用于定义cout，cin和cerr对象，分别对应于标准输出流，标准输入流和标准错误流
 <iomanip>它用于声明对执行格式化I/O的服务，如:setprecision和setw
 <fstream>用于声明用户控制文件处理的服务
 
 标准输出流cout
 cout是ostream类的预定义对象，它与标准输出设备连接，通常是一个显示屏。cout与流插入运算符<<结合使用，在控制台上显示输出
 
 标准输入流cin
 cin是istream类的预定义对象，它与标准输入设备连接，标准输入设备通常是键盘。cin与流提取预算副>>结合使用，从控制台读取输入
 
 数据类型指定变量可存储的数据类型，例如整数浮点字符等
 C++数据类型
 基本数据类型 int char,float,double等
 派生数据类型 数组，指针等
 枚举数据类型 枚举
 用户定义数据类型 结构体
 基本数据类型
 */

using namespace std;
//using namespace std::cin; 可能效果会更好
int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    cout << "no std ::" << endl;
    
    std::cout << "Welcome to C++ Programming.\n";
    
    char array[] = "Welcome to C++ tutorial";
    std::cout << "Value of array is " << array << std::endl;
    //using namespace std
    int age;
    cout << "Enter your age:";
    cin >> age;
    cout << "Your age is:" << age << endl;
    
    cout << "C++ Tutorial";
    cout << "www.baidu.com" << endl;
    cout << "End of line" << endl;
    
    
    return 0;
}
