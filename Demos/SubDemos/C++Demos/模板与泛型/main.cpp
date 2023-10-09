//
//  main.cpp
//  模板与泛型
//
//  Created by 周位杰 on 2022/4/30.
//

#include <iostream>
//#include <string>

using namespace std;

//模板分为函数模板和类模板
template <typename T>//也可以使用Class：template<class T>
T& max(T& a, T& b) {
    return a > b ? a : b;
}
//模板函数的重载
class Person {
public:
    int age;
    Person(){};
    Person(int age):age(age){};
    template<class T>
    T& min(T& a, T& b) {
        return a < b ? a : b;
    }
    //模板函数也可以重载，当上面的方式不能比较Person时，会调用下面这个函数来比较Person：
    Person& min(Person& a, Person& b) {
        if (a.age < b.age) {
            return a;
        } else {
            return b;
        }
    }
};

//模板类
template<class T1, class T2=int>//可以指定T2类型默认为int
class Animal {
public:
    T1 t1;
    T2 t2;
    Animal(T1 t1, T2 t2):t1(t1),t2(t2){};
    void run() {
        cout << "Animal run" << endl;
    }
    void print() {
        cout << "t1 : " << t1 << " , t2 : " << t2 << endl;
    }
};

int main(int argc, const char * argv[]) {
    //max
    int t1 = max(1, 2);
    cout << t1 << endl;
    cout << max(1.1, 2.1) << endl;
    cout << max('a', 'b') << endl;
    
    //min
    Person p;
    Person p1(18);
    Person p2(19);
    p = p.min(p1,p2);
    cout << p.age << endl;
    
    //模板类
    Animal<string, float> a1("name", 8.0);
    Animal<int> a2(18,19);
    a1.print();
    a2.print();
    return 0;
}
