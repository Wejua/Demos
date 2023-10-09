//
//  main.cpp
//  类型定义
//
//  Created by 周位杰 on 2022/4/21.
//

#include <iostream>

using namespace std;

//struct后可以没有类型，正常要加上，这里试错而已
typedef struct {
    int x;
    int y;
} Point;

//struct后需要有类型，不然编译警告
typedef class Person {
public:
    int age;
} Customer;

int main(int argc, const char * argv[]) {
    //1
    Point p;
    p.x = 10;
    p.y = 10;
    
    //2
    Customer c;
    c.age = 10;
    cout << endl << c.age << endl;
    
    //3
    typedef int myint;
    myint age = 18;
    myint pid = 111;
    cout << endl << age << endl << pid << endl;
    
    return 0;
}
