//
//  main.cpp
//  向量vector
//
//  Created by 周位杰 on 2022/4/23.
//

#include <iostream>
#include <vector>

using namespace std;

int main(int argc, const char * argv[]) {
    vector<int> v;
    v.push_back(1);//往后添加元素
    v.push_back(2);
    v.push_back(3);
    v.push_back(4);
    v.push_back(5);
    
    //遍历
    for (int i : v) {
        cout << i << endl;
    }
    
    cout << "迭代器遍历:" << endl;
    //迭代器遍历
    vector<int>::const_iterator it = v.begin();
    while (it != v.end()) {
        cout << *it++ << endl;//++比*优先级高，++是跳跃一个元素位置，不是一个字节
    }
    
    cout << "front() : " << v.front() << endl;
    cout << "back() : " << v.back() << endl;
    cout << "size() :" << v.size() << endl;//元素个数
    cout << "capacity() :" << v.capacity() << endl;//容量，大于等于size()
    
    return 0;
}
