//
//  JAVP.cpp
//  JACCC
//
//  Created by xiazhongchong on 18/01/2018.
//  Copyright © 2018 JJFly. All rights reserved.
//

/**
 C++数据抽象
 
 C++命名空间
 C++中的命名空间用于组织项目中的类，以便处理应用程序结构
 对于访问命名空间的类，我们需要使用namespace：：classsname。可以使用using关键字，所以不必一直使用完整的名称
 在C++中，全局命名空间是根命名空间。global::std总是引用C++空间的命名空间“std";
 
 在C++编程中，使用try/catch语句执行异常处理。C++try块用于放置可能发生异常的代码。catch块用于处理异常
 
 */
#include <stdio.h>
#include  <iostream>
#include <cstring>
#include <exception>
using namespace std;
namespace First {
    void sayHello() {
        cout << "Hello First Namespace" << endl;
    }
}

namespace Second {
    void sayHello() {
        cout << "Hello second namespace" << endl;
    }
}

class Sum {
private: int x, y, z;
public:
    void add() {
        std::cout << "Enter two numbers:";
        std::cin >> x >> y;
        z = x + y;
        std::cout << "sum of two number is:" << z << std::endl;
    }
};

float division(int x, int y) {
    if (y == 0) {
        throw "Attempted to divide by zero";
    }
    return (x / y);
}

class MyException:public exception {
public:
    const char * what() const throw() {
        return "Attempted to divide by zero!\n";
    }
};


//using namespace First;
int main (){
    
    Sum sum;
    sum.add();
    
    First::sayHello();
    Second::sayHello();
    
//    sayHello();
    
    string str = "Hello";
    char ch[] = {'C', '+', '+'};
    string s2 = string(ch);
    cout << str << endl;//hello
    cout << s2 << endl;//c++
    
    char key[] = "mango";
    char buffer[50];
    do {
        cout << "what is my favourite fruit?";
        cin >> buffer;
    } while (strcmp(key, buffer) != 0);
    cout << "answer is correct" << endl;
    
    char keyStr[25], bufferStr[25];
    cout << "Enter the buffer string";
    cin.getline(keyStr, 25);//welcome to
    cout << "Enter the buffer string";
    cin.getline(bufferStr, 25);//c++ programming
    strcat(keyStr, bufferStr);
    cout << "key = " << keyStr << endl;//welcome to C++ programming
    cout << "buffer = " << bufferStr << endl;//C++ programming
    
    cout << "length of string" << strlen(keyStr) << endl;
    
    int i = 25;
    int j = 0;
    float k = 0;
    try {
        k = division(i, j);
    } catch (const char *e) {
        cerr << e << endl;
    }//attempted to divide by zero!.
    
    
    return 0;
}
