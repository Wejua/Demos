//
//  main.cpp
//  C++Demos
//
//  Created by 周位杰 on 2022/4/21.
//

#include <iostream>
#include <string>

#pragma mark - 类

using namespace std;
//类的声明，也可以单独写在一个.h文件中
class Person {
private:
    int _pid;
    string _name;
    int _age;
public:
    //构造函数和析构函数
    Person();
    ~Person();
    //方法的声明
    void set_pid(int pid);
    int get_pid();
    
    void set_name(string name);
    string get_name();
    
    void set_age(int age);
    int get_age();
};

Person::Person() {
    cout << "构造函数" << endl;
}

Person::~Person() {
    cout << "析构函数" << endl;
}

//类的实现
void Person::set_pid(int pid) {
    _pid = pid;
    //也可以这样写
    this -> _pid = pid;
}
int Person::get_pid() {
    return _pid;
}

void Person::set_name(string name) {
    this -> _name = name;
}
string Person::get_name() {
    return this -> _name;
}

void Person::set_age(int age) {
    this -> _age = age;
}
int Person::get_age() {
    return this -> _age;
}

int main(int argc, const char * argv[]) {
    //第一种方式写
    Person per;
    per.set_pid(123);
    per.set_name("刘世明");
    per.set_age(18);
    cout << "per: Person {" << endl;
    cout << "_pid: " << per.get_pid() << endl << "_name: " << per.get_name() << endl << "_age: " << per.get_age() << endl;
    cout << "}" << endl;
    
    cout << endl << "----------------------------" << endl << endl;
    
    //第二种方式写
    Person *per2 = new Person();
    per2 -> set_pid(1);
    per2 -> set_name("明");
    per2 -> set_age(19);
    cout << "per2: Person {" << endl;
    cout << "_pid: " << per2->get_pid() << endl << "_name: " << per2->get_name() << endl << "_age: " << per2->get_age() << endl;
    cout << "}" << endl;
    
    return 0;
}
