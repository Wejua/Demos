//
//  main.cpp
//  加号运算符重载
//
//  Created by 周位杰 on 2022/4/30.
//

#include <iostream>

using namespace std;

class Person {
private:
    string name;
    int age;
    //第二种方式，声明成私有友元函数，不是友元函数不能访问p1的成员
    friend Person& operator+(Person& p1, Person p2);
public:
    Person(string name, int age):name(name),age(age){};
//    Person& operator+(Person& p2);
    void print() {
        cout << name << "," << age << endl;
    }
};

//Person& Person::operator+(Person &p2) {//成员函数默认第一个形参是this指针，用两个形参会编译错误，改成私有友元函数可以。
//    this -> name = this -> name + p2.name;
//    this -> age += p2.age;
//    return *this;
//}

//用友元函数实现
Person& operator+(Person& p1, Person p2) {
    p1.name+=p2.name;
    p1.age+=p2.age;
    return p1;
}

int main(int argc, const char * argv[]) {
    Person p1("name1",18);
    Person p2("name2",19);
    Person p3 = p1 + p2;
    p1.print();
    p2.print();
    p3.print();
    cout << &p1 << endl;
    cout << &p2 << endl;
    cout << &p3 << endl;
    return 0;
}
