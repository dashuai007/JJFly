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
 基本数据类型是基于整数和浮点的。C++语言支持有符号和无符号文字。基本数据类型的内存大小可能会根据32位或64位操作系统而改变
 32位操作系统
 char               1byte -128~127
 signed char        1byte -128~127
 unsigned char      1     0~127
 short              2     -32768 ...
 
 C语言关键字C++可用
 double else enum extern float for goto if int long register return short signed sizeof static struct switch typedef union unsigned void volatile while
 C语言中不可用的30个C++语言关键字列表
 asm dynamic_cast namespace retinterpret_cast bool explicit new static_cast false catch operator template friend private class this  inline public throw const_cast delete mutable protected true try typeid typename using virtual wchar_t
 
 C++运算符
 素数运算符、关系运算符、逻辑运算符、按位运算符、赋值运算符、一元运算符、三元或条件运算符、杂项操作员
 
 C++中的数组是一组具有连续内存为指导类似类型的元素。在C++中std::array是一个封装固定大小数组的容器。在C++中，数组索引从0开始。我们可以在C++数组中只存储固定的元素集合
 
 C++编程中，if语句用于测试条件。
 if语句 if-else语句 嵌套if语句 if-else-if
 
 如果for循环中使用双分好，它将执行无限次。
 break结束循环
 continue结束当前循环，继续下一个循环
 goto跳转语句。它用于将控制转移程序的其他部分。它无条件跳转到指定标签。它可用于从深层嵌套循环或switch case标签传输机
 
 C++函数
 C++语言中的函数在其他编程语言中也称为过程或子例程
 我们可以创建函数来执行任何任务。一个函数可以调用多次。它提供模块化和代码可重用性。
 C++中函数的有点：
 1.提高代码的可重用性 2.代码优化
 
 函数类型
 C++编程语言中有两种类型的函数：
 库函数（在C++头文件中声明的函数，如ceil(x), cos(x), exp(x)等）
 用户定义函数
 
 有两种方法可以将值或数据传给C++语言的函数：通过值调用和通过引用调用。原始值在值调用中不会被修改，但通过引用调用中会被修改。
 
 值调用中，不修改原始值
 在值调用中，传递给函数的值由函数参数本地存储在堆栈存储器。如果给该函数参数的值，则仅更改当前函数的值，函数内修改的参数值不会反映到函数的外部。它不会改变调用方法中的变量的值。
 在引用调用中原始值会被修改，因为我们通过引用地址来调用的。这里值的地址在函数中传递，因为实际和形式参数共享相同的地址空间。因此，在函数内部改变的值会反映在函数的内部以及外部。
 
 ====通过值调用->将值的副本传递给函数，函数内不得给该不会反映在外部，实际和形式参数将在不同的内存位置创建
 ====通过引用调用->将值的地址传递给函数，在函数内部进行的更改也反映在函数外部，实际和形式参数将在同一内存位置创建
 
 C++存储类
 存储类用于定义C++程序中变量和函数的生命周期和可见性
 寿命是指变量保持活动的时间段，可见性是指可访问变量的程序的模块。
 有五种类型的存储类可以再C++程序中使用
 自动；寄存器；静态；外部；可变
 
 C++指针
 C++语言中的指针是一个变量，它也称为定位符或指示符，它是指向一个值的地址。
 指针的有点：
 指针减少代码并提高性能，它用于检索字符串，树等，并与数组，结构和函数一起使用
 我们可以使用指针从函数返回多个值
 它能访问计算机内存中的任何内存位置。
 
 指针的使用
 在C++语言中由于多指针的使用。
 动态内存分配在C语言中可以使用malloc()和calloc()函数动态分配内存，其中使用的就是指针。
 数组、函数和结构体
 C语言中的指针被广泛用于数组，函数和结构体中，它减少了代码并提高了性能。
 & 地址运算符 获取变量的地址
 * 间接运算符 访问地址的值
 
 */

using namespace std;
//using namespace std::cin; 可能效果会更好

void swap(int *x, int *y) {
    int temp;
    temp = *x;
    *x = *y;
    *y = temp;
}

int factorica(int n) {
    if (n < 0)
        return (-1);
    if (n == 0)
        return 1;
    else {
        return n * factorica(n - 1);
    }
}


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
    
    int arr[5] = {10, 0, 20, 0, 30};
    for (int i = 0; i < 5; i++) {
        std::cout << arr[i] << "\n";
    }
    
    for (int i : arr) {
        std::cout << i << "\n";
    }
    
    if (age % 2 == 0) {
        std::cout << "It is a num"<<std::endl;
    } else {
        std::cout << "It is not a num" << std::endl;
    }
    
//    for (; ; ) {
//        std::cout << "Maybe do no countable times"<< std::endl;
//    }
    
    int x = 50, y = 100;
    swap(&x, &y);
    std::cout << "Value of x is:" << x << std::endl;
    std::cout << "Value of y is:" << y << std::endl;
    
    
    int  fact = 5, value;
    value = factorica(fact);
    std::cout << "value of factorica:" << value << std::endl;
    
    return 0;
}
