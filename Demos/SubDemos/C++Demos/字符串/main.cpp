//
//  main.cpp
//  字符串
//
//  Created by 周位杰 on 2022/4/23.
//

#include <iostream>
#include <string>

using namespace std;

void test_getline();

int main(int argc, const char * argv[]) {
    //初始化
    string s1 = "strings1";
    string s2(s1);//s2为s1的副本
    string s3("hello");//初始化为hello
    string s4(3, 'a');//初始化为3个a
    cout << s1 << endl << s2 << endl << s3 << endl << s4 << endl;
    
    string s5(s1,1,3);//tri，第一位到第三位截取s1，包括第一位和第三位
    string s6(s1,2);//rings1，从第二位开始截取s1得到s6，包括第二位
    char no_null[] = {1,3};
    string s7(no_null);//错误，没有’\0‘结5

    //+运算
    string s = "123";
    s = s + "456";
    cout << s << endl;
    
    //获取键盘输入，cin遇到空格会终止，getline不会
//    test_getline();
    
    //empty(),size(),
    string s5 = "strings5";
    cout<<"empty : "<<s5.empty()<<endl;
    cout<<"size: "<<s5.size()<<endl;
    //resize
    s5.resize(5);
    cout<<"resize: "<<s5<<endl;
    //字符串长度小于10，就拼接a字符到所有增加的空间。字符串长度大于10就裁剪字符串到长度为10，不拼接a
    s5.resize(10, 'a');
    cout<<s5<<endl;
    
    return 0;
}

void test_getline() {
    string s;
    cout<<"请输入字符串,我会打印出来:"<<endl;
    while (getline(cin, s)) {
        if (s=="exit"){//输入exit就会退出
            break;
        }
        cout<<s<<endl;
    }
}
