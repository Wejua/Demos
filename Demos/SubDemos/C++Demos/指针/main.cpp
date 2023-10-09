//
//  main.cpp
//  指针
//
//  Created by 周位杰 on 2022/4/23.
//

#include <iostream>

using namespace std;

struct Person {
    string _name;
    int _age;
//    Person();//前面没有void，是构造函数
    Person():_name(""),_age(0){};
    Person(int age, string name):_age(age),_name(name){};//第二个构造函数
    void set_age(int age) const;//加了const，在这个成员函数内就不能修改Person内部的值
};

int main(int argc, const char * argv[]) {
    int i = 0;
    int *p = &i;//或者int* p = i;
    //数组赋值给指针不用取地址，a的值就是第一个元素的地址
    int a[10];
    int *p1 = a;
    //下面三个都是一个结果
    *p = NULL;//NULL就是0
    p = nullptr;
    
    void *p3 = &i;//void *可以保存任意类型的指针
    
    //引用（别名）
    int &pp = i;
    
    return 0;
}


