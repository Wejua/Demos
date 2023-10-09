//
//  main.cpp
//  数组
//
//  Created by 周位杰 on 2022/4/23.
//

#include <iostream>

using namespace std;

class Person {
    int age;
};

int main(int argc, const char * argv[]) {
    const int size = 10;
    int a[size];
    for (int i=0; i<size; i++) {
        cout << a[i] << endl;
    }
    //存对象
    const int capacity = 10;
    Person pers[capacity];
    Person p1;
    Person p2;
    Person p3;
    pers[0] = p1;
    pers[1] = p2;
    pers[2] = p3;
    for (int i = 0; i < capacity; i++) {
        cout << &pers[i] << endl;
    }
    
    //初始化方式
    int a1[] = {1,2,3,4,5};
    int a2[10];//新建数组，各元素不初始化
    int a3[10] = {};//各元素初始化为0
    int a4[10] = {1};//第一个元素初始化为1，其它为0
    int a5[10] = {1,2,3};//前三个元素分别为1,2,3。其它元素都初始化为0
    
    cout << "a1 : " << endl;
    for (int i=0;i<5;i++) {
        cout << a1[i] << endl;
    }
    cout << "a2 : " << endl;
    for (int i=0;i<10;i++) {
        cout << a2[i] << endl;
    }
    
    return 0;
}
