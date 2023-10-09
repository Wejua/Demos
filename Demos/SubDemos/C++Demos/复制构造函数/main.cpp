//
//  main.cpp
//  复制构造函数
//
//  Created by 周位杰 on 2022/4/28.
//

#include <iostream>

using namespace std;

class Person {
public:
    long j;
    long k;
    Person(){};
    ~Person(){};
    Person returnself(){//返回的是Person&类型就不会调用复制构造函数，因为那样表示返回类型是地址
        cout << "returnself方法" << endl;
        return *this;//会调用复制构造函数4
    };
//private://打开注释，需要调用复制构造函数的地方会编译错误
    Person(const Person& per);//要防止调用复制构造函数，只需将这个方法改成private，不写这个方法会调用默认的
};

Person::Person(const Person& per) {
    cout << "调用了复制构造函数" << endl;
}

void test(Person p) {
    cout << "test方法" << endl;
}

int main(int argc, const char * argv[]) {
    Person per1;
    Person per2(per1);//会调用复制构造函数1
    Person per3 = per1;//会调用复制构造函数2
    Person *per4 = new Person;//person在堆空间，上面几个变量都在栈空间
    
    test(per1);//会调用复制构造函数3
    per1.returnself();
    //会调用复制构造函数的原因是因为是值传递，把类当值传递当然要复制一份。如果是地址传递（引用）就不会调用。指针传递也不会调用：
    Person *per5 = per4;//不会调用，因为是指针传递
    Person per6 = *per4;//会调用，因为是值传递
    
    //不管有没有实现复制构造函数，都会打印出不一样的地址
    cout << "per1 : " << &per1 << endl;
    cout << "per2 : " << &per2 << endl;
    cout << "per3 : " << &per3 << endl;
    cout << "per4 : " << per4 << endl;
    return 0;
}
