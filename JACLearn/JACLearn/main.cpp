//
//  main.cpp
//  JACLearn
//
//  Created by xiazhongchong on 23/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#include <iostream>

typedef int CFeet;

enum Color {
    redColor,//0
    greenColor = 5,
    blueColor,//6
}color;

int main(int argc, const char * argv[]) {
    // insert code here...
    
    std::cout << "Hello John!" << std::endl;
    
    std::cout << "Hello cout";
    
    std::cout << "Hello, World!\n";
    
    std::cout << "Hello, C++!\n";
    
    
    std::cout << "size of wchar_t \n" << sizeof(wchar_t) << std::endl;
    std::cout << "size of unsigned int " << sizeof(unsigned int) << std::endl;
    
    
    CFeet prizePrice;
    color = blueColor;
    
    return 0;
}
