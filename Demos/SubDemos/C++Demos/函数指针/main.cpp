//
//  main.cpp
//  函数指针
//
//  Created by 周位杰 on 2022/4/24.
//

#include <iostream>

using namespace std;

int getmax(int a, int b) {
    int max = a > b ? a : b;
    cout << max << endl;
    return max;
}

void func1(int(*m)(int a, int b)) {
    m(1, 2);
}

int func2(int a, int b) {
    int max = a > b ? a : b;
    cout << "max : " << max << endl;
    return max;
}

int main(int argc, const char * argv[]) {
    //函数指针
    typedef int (*fuc_ptr)(int, int);
    fuc_ptr func = getmax;
    func(1,3);
    
    //函数指针作为形参
    func1(func2);
    
    return 0;
}
