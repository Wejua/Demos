//
//  main.cpp
//  析构函数
//
//  Created by 周位杰 on 2022/4/30.
//

#include <iostream>
#include <fstream>

using namespace std;

class Person {
private:
    string name;
    int age;
    ifstream in;
    int *p;
public:
    Person(){
        p = new int();
        in.open("test.txt",ios::in);
        cout << "constuctor" << endl;
    }
    ~Person(){
        delete p;
        in.close();
        cout << "destuctor" << endl;
    }
};

int main(int argc, const char * argv[]) {
    Person *p = new Person;
    delete p;
    return 0;
}
