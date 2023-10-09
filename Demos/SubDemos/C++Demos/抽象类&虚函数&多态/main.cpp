//
//  main.cpp
//  抽象类&虚函数&多态
//
//  Created by 周位杰 on 2022/4/30.
//

#include <iostream>

using namespace std;

class Person {
public:
    //包含虚函数的类就是抽象类
    virtual void run()=0;//没有实现的虚函数
    virtual void sit(){//有默认实现的虚函数，子类可以不重写
        cout << "Person set" << endl;
    };
};

class Student : public Person {
public:
    void run() {
        cout << "Student run" << endl;
    }
};

class Teacher : public Person {
public:
    void run() {
//        this -> Person::sit();
        cout << "Teacher run" << endl;
    }
    void sit() {
        cout << "Teacher sit" << endl;
    }
};

int main(int argc, const char * argv[]) {
    Student s;
    Teacher t;
    s.run();
    t.run();
    //多态按字面的意思就是多种形态。当类之间存在层次结构，并且类之间是通过继承关联时，就会用到多态。
    //C++多态意味着调用成员函数时，会根据调用函数的对象的类型来执行不同的函数:
    Person *p = &s;
    p -> sit();
    p = &t;
    p -> sit();
    return 0;
}
