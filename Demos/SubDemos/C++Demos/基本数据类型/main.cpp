//
//  main.cpp
//  基本数据类型
//
//  Created by 周位杰 on 2022/4/21.
//

#include <iostream>
using namespace std;

extern const int ei = 100;

int main(int argc, const char * argv[]) {
    bool b = false;
    cout << "bool = " << b << " : " << sizeof(b) << endl;
    
    char c = 'A';
    cout << "char = " << c << " : " << sizeof(c) << endl;
    //宽字符
    wchar_t wc = 'B';
    cout << "wchar_t = " << wc << " : " << sizeof(wc) << endl;
    
    short s = 100;
    cout << "short = " << s << " : " << sizeof(s) << endl;
    
    int i = 222;
    cout << "int = " << i << " : " << sizeof(i) << endl;
    
    long l = 1894;
    cout << "long = " << l << " : " << sizeof(l) << endl;
    //单精度浮点数
    float f = 23.44;
    cout << "float = " << f << " : " << sizeof(f) << endl;
    
    //双精度浮点数
    double d = 456.78840;
    cout << "double = " << d << " : " << sizeof(d) << endl;
    
    //拓展精度浮点数
    long double ld = 3445.9987;
    cout << "long double = " << ld << " : " << sizeof(ld) << endl;
    
    //无符号整型
    unsigned int ui = 33;
    cout << "unsigned int = " << ui << " : " << sizeof(ui) << endl;
    
    extern const int ei;
    cout << "ei =" << ei << endl;
    return 0;
}
