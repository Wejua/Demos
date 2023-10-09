//
//  main.cpp
//  运算符重载
//
//  Created by 周位杰 on 2022/4/30.
//

#include <iostream>
#include <string>

using namespace std;

class Person {
public:
    string name;
    int age;
    void print(){
        cout << "Person:{" << endl;
        cout << name << endl << age << endl << "}" << endl;
    }
    Person& operator=(const Person& p) {//返回值地方，和参数地方都得加&，不然会调用复制构造函数复制一份
        name = p.name;
        age = p.age;
        return *this;
    }
    Person(){};
    Person(Person& per) {
        cout << "调用了复制构造函数" << endl;
        name = per.name.append("复制");
        age = per.age;
    }
};

int main(int argc, const char * argv[]) {
    Person p1;
//    Person p2;
    p1.name = "name";
    p1.age = 18;
//    p2 = p1;//不调用复制构造函数，会调用=运算符重构函数，复制正常
    Person p2 = p1;//不会调用=运算符重载函数，会调用复制构造函数
    p1.print();
    p2.print();
    
    cout << "p1:" << &p1 << endl;
    cout << "p2:" << &p2 << endl;
    return 0;
}
