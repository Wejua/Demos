//
//  main.cpp
//  友元Friend
//
//  Created by 周位杰 on 2022/4/28.
//

#include <iostream>

class B;

class A {
    friend B;//B中可以访问A中的private成员变量和函数
    friend void friend_func(A a);//友元函数，不是类中的成员函数B::b_func(A a)编译错误
private:
    int i;
    int j;
    void a_func() {
        std::cout << "a_func" << std::endl;
    };
};

class B {
public:
    void b_func(A a);
};

void B::b_func(A a) {
    a.i = 100;
    a.j = 200;
    std::cout << "a.i = " << a.i << std::endl;
    std::cout << "a.j = " << a.j << std::endl;
    a.a_func();
}

void friend_func(A a) {
    a.i = 300;
    a.j = 400;
    std::cout << "a.i = " << a.i << std::endl;
    std::cout << "a.j = " << a.j << std::endl;
    a.a_func();
}

int main(int argc, const char * argv[]) {
    A a;
    B b;
    b.b_func(a);
    friend_func(a);
    return 0;
}
