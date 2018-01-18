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
 */
#include <stdio.h>
#include  <iostream>
#include <cstring>
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
    
    
    return 0;
}
