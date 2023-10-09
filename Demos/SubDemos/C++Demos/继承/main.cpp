//
//  main.cpp
//  继承
//
//  Created by 周位杰 on 2022/4/30.
//

#include <iostream>

using namespace std;
//private, protected, public，这三个都不写默认就是private
class Person {
private:
    string name;
    int age;
protected:
    
public:
    Person(string name, int age):name(name),age(age){};
    void print(){
        cout << "name : " << name << " , " << "age : " << age << endl;
    };
};
/*继承方式（不写默认就是private）：
 private继承会使得父类的protected和public成员被该子类访问时变成private
 protected继承会使得父类的public成员被该子类访问时变成protected
 public继承不影响
*/
class Student : public Person {
private:
    int score;
protected:
public:
    Student(string name, int age, int score):Person(name, age),score(score){};
    void print() {
        Person::print();
        cout << "score : " << score << endl;
    }
};

class Manage {
    
};

//多继承
class Tom : public Person, public Manage {
    
};

int main(int argc, const char * argv[]) {
    Student stu("name", 18, 90);
    stu.print();
    stu.Person::print();//protected和private继承会使得这个方法不能访问
    return 0;
}
