//
//  main.cpp
//  引用
//
//  Created by 周位杰 on 2022/4/21.
//

#include <iostream>

using namespace std;

void swap(int a, int b);
void swap2(int& a, int& b);

int main(int argc, const char * argv[]) {
    int a = 1;
    int b = 2;
    //swap不能正常交换
    swap(a, b);
    cout << "a = " << a << endl;
    cout << "b = " << b << endl;
    
    //swap2正常交换
    int c = 3;
    int d = 4;
    swap2(c, d);
    cout << "c = " << c << endl;
    cout << "d = " << d << endl;
    
    //别名，其实就是地址（引用）类型
    int e = 5;
    int& f = e;//f是e的别名
//    int& x;//不初始化会编译错误
    cout << "f = " << f << endl;
    
    return 0;
}

void swap(int a, int b) {
    int temp = a;
    a = b;
    b = temp;
}

void swap2(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}
