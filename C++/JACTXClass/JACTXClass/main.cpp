//
//  main.cpp
//  JACTXClass
//
//  Created by xiazhongchong on 01/02/2018.
//  Copyright © 2018 esunny. All rights reserved.
//

#include <iostream>
#include <string>
using namespace::std;

namespace ONE {
    int m= 200;
    int inf  = 100;
}

namespace TWO {
    int n = 100;
    int inf = 2;
}


/**
 内联函数 不能包含复杂的语句不能包含for switch while、递归函数
 小型的、被频繁调用的函数、是和 1 ~ 5 line函数
 
 函数的重载 顺序 自动识别
 
 template 函数模板
 */
int square(int a) {
    cout << __FILE__ << " " << __LINE__ << " " << __FUNCTION__ << endl;
    return a * a;
}

float square(float a) {
    cout << __FILE__ << " " << __LINE__ << " " << __FUNCTION__ << endl;
    return a * a;
}

double square(double a) {
    cout << __FILE__ << " " << __LINE__ << " " << __FUNCTION__ << endl;
    return a * a;
}

template <typename TT>
TT abst(TT x) {
    return x < 0 ? -x : x;
}


inline bool isNumber(char ch) {
    return (ch >= '0') && (ch <= '9');
}

class Student {
public:
    Student();//构造函数
    ~Student();//析构函数
private:
    int id;
    float score;
};

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    cout << "Hello, CPP With Namespace" << endl;
    
    using namespace ONE;
    m = 100;
    using namespace TWO;
    cout << "m value is " << m << endl;
    cout << "inf value is " << ONE::inf << endl;
    cout << "Two::inf value is " << TWO::inf << endl;
    cout << "Two::n value is " << TWO::n << endl;
    
    cout << square(10) << endl;
    cout << square(2.5f) << endl;
    cout << square(1.1) << endl;
    
    cout << abst(-100.2) << endl;
    
    string str("newStr");
    str.append(" dou");
    cout << "value of str is " << str + " new" << endl;
    str.empty();
    str.size();
    
    return 0;
}
