//
//  main.cpp
//  顺序容器
//
//  Created by 周位杰 on 2022/4/24.
//

#include <iostream>
#include <vector>
#include <deque>
#include <list>
#include <stack>
#include <queue>

using namespace std;

class Person {
public:
    int age;
    void print(){cout<<age<<endl;}//内联函数
};

int main(int argc, const char * argv[]) {
    //vector，数组，快速随机访问，插入删除慢
    //list，双向链表
    //deque(double ended queue)，两边插入删除比较快，中间比较低
    //顺序容器的适配器（）
    //stack,LIFO（后进先出）
    //queue，FIFO（先进先出）
    //priority_queue,按优先级排列
    
    vector<int> v1;
    vector<string> v2;
    vector<Person> v3;
//    vector<int> vtest(v1.begin(), v1.begin()+3);//取v1里的第一个到四个来初始化vtest，v1没有数据的话会崩
    
    //迭代器
    Person p1;
    p1.age = 18;
    Person p2;
    p2.age = 19;
    v3.push_back(p1);
    v3.push_back(p2);
    vector<Person>::iterator it = v3.begin();
    while (it != v3.end()) {
        it -> print();
        it++;
    }
    Person tempp = *it;//经过++之后，这里指向end()位置了，最后一个元素的结尾，所以打印不正常值
//    tempp.print();
    
    //容器类型别名
    vector<int>::size_type t = v1.size();//容器长度
    vector<int>::iterator itrator;//迭代器
    vector<int>::const_iterator citrator;//只读迭代器
    vector<int>::reverse_iterator reit;//反向迭代器
    vector<int>::difference_type difft;//两个迭代器差值
    vector<int>::value_type vt;//元素的类型
    int i;
    vector<int>::reference ref = i;//元素的引用
    vector<int>::const_reference cref = i;//元素的常量引用
    
    //begin()指向第一个元素的前面，end()指向最后一个元素的后面。rbegin()指向最后一个元素的前面，rend()指向第一个元素的前面
    //push_back(e)，末尾添加元素，push_front(e)，前端添加元素（list，deque才行）
    //insert(p,e)，指定位置p，插入元素e，insert(p,n,e)指定位置p插入n个元素e，instert(p,b,e)指定位置p插入b迭代器到e迭代器的所有元素
    //注意：添加或删除元素会使迭代器失效
    //size()容器大小，max_size()最多可容纳大小，empty()是否为空，resize(n)调整大小，resize(n,e)调整大小为n,新加位置都为e
    //front()第一个元素的引用，back()最后一个元素的引用，c[n]在n位置元素的引用（vector和deque）c.at(n)在n位置元素的引用
    //erase(b)删除b位置迭代器元素,erase(v1.begin(),v1.begin()+2)删除从b到e的迭代器元素,clear()清空,pop_back()删除最后一个,pop_front()删除第一个
    //c1.swap(c2)c1和c2元素交换，c.assign(v1.begin(),v1.begin()+3)使用v1的开始到开始+3的元素重置c,c.assign(n,t)将c重置为存储n个t的容器
    //vector分配的空间会比实际使用的空间大，这样提高了效率
    vector<int> v10;
    cout << "size() : " << v10.size() << endl;//当前大小
    cout << "capacity() : " << v10.capacity() << endl;//空间大小
    for (int i = 0; i < 10; i++) {
        v10.push_back(i);
    }
    //设置预留空间
    v10.reserve(30);
    cout << "after reserve size() : " << v10.size() << endl;//当前大小
    cout << "after reserve capacity() : " << v10.capacity() << endl;//空间大小
    
    
    list<int> l1;
    list<string> l2;
    list<Person> l3;
    
    deque<int> d1;
    deque<string> d2;
    deque<Person> d3;
    
    //容器类元素的约束
    //1. 必须支持赋值运算，引用类型不支持，所以不行
    //2. 元素类型必须支持赋值，iO类型不支持，所以不行
    //注意：
    //如果可以随机访问（位置）使用vector和deque
    //头部插入选deque，尾部选vector，中间插入选list
    
    string s;
    
    //其它容器，有人说是容器适配器
    stack<int> sta;
    queue<int> que;
    priority_queue<int> priq;
    
    return 0;
}
