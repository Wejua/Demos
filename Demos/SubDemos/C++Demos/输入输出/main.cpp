//
//  main.cpp
//  输入输出
//
//  Created by 周位杰 on 2022/4/24.
//

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

//输入输出状态
void state() {
    cout << "请输入一个整数：" << endl;
    int i;
    cin >> i;
    istream::iostate state = cin.rdstate();
    switch (state) {
        case istream::badbit:
            cout << "badbit" << endl;//被破坏
            break;
        case istream::failbit:
            cout << "failbit" << endl;//失败的操作
            break;
        case istream::goodbit:
            cout << "goodbit" << endl;//有效状态
            break;
        case istream::eofbit:
            cout << "eofbit" << endl;//到达文件尾
            break;
        default:
            cout << "default" << endl;
            break;
    }
}

/*打开文件的方式
 typedef unsigned int openmode;
 static const openmode app    = 0x01;//追加
 static const openmode ate    = 0x02;//文件指针指向文件末尾
 static const openmode binary = 0x04;//打开二进制文件
 static const openmode in     = 0x08;//以输入方式打开，只读
 static const openmode out    = 0x10;//以输出方式打开，只写
 static const openmode trunc  = 0x20;//覆盖，清除文件数据
 */
void fileOpen() {
    //打开文件方式一
//    ofstream out("test.txt", ios::out);
    //打开文件方式二
    ofstream ofile;
    ofile.open("test1.txt", ios::out);
    if (!ofile.fail()) {
        ofile << "tom ";
        ofile << "male ";
        ofile << "20";
    }
    ofile.flush();//刷新缓冲区
    ofile.close();//关闭流
    
    //文件读取
    ifstream in;
    in.open("test1.txt", ios::out);
    char c;
    while (!in.eof()) {
        c = in.get();
        cout << c;
    }
    cout << endl;
    in.close();
}

//字符串输入输出
void string_stream() {
    string line,word;
    cout << "请输入一行字符串：" << endl;
    while (getline(cin, line)) {
        istringstream iss(line);
        while (iss>>word) {
            cout<<word<<endl;
        }
        cout << "请输入一行字符串：" << endl;
    }
}

int main(int argc, const char * argv[]) {
//    state();
//    fileOpen();
    string_stream();
    
    return 0;
}
