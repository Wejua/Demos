//
//  main.cpp
//  关联容器
//
//  Created by 周位杰 on 2022/4/28.
//

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <set>

#include <algorithm>
#include <numeric>

using namespace std;

int main(int argc, const char * argv[]) {
    //pair
    pair<int, string> pa1;
    pair<string, vector<int>> pa2;
    vector<int> ve1;
    pa2 = make_pair("keykey", ve1);
    cout << "pa2.first : " << pa2.first << endl;//键
    cout << "pa2.second : " << &pa2.second << endl;//值
    
    //map（关联数组）
    map<string, string> map1;
    map1["1"] = "one";
    map1["2"] = "two";
    map1["3"] = "three";
    cout << map1.begin() -> first << endl;
    map<string, string> map2(map1);
    map<string, string> map3(map1.begin(), map1.end());
    pair<string, string> pa3;
    pa3 = make_pair("4", "four");
    //插入
    map1.insert(pa3);
    //遍历
    map<string, string>::iterator it = map1.begin();
    while(it != map1.end()) {
        cout << it -> first << " : " << it -> second << endl;
        it++;
    }
    
    //set（不可重复）
    vector<int> v1;
    v1.push_back(1111);
    v1.push_back(1111);
    v1.push_back(2222);
    v1.push_back(2222);
    set<int> s1(v1.begin(), v1.end());
    set<int,int> s2;
    
    cout << "v1.size() : " << v1.size() << endl;
    cout << "s1.size() : " << s1.size() << endl;
    //遍历
    set<int>::iterator it2 = s1.begin();
    while(it2!=s1.end()) {
        cout << *it2++ << endl;
    }
    //查找和删除
    it2 = s1.find(1111);
    s1.erase(1111);
 
    //非修正算法
//    count(<#_InputIterator __first#>, <#_InputIterator __last#>, <#const _Tp &__value_#>)
//    find(<#_InputIterator __first#>, <#_InputIterator __last#>, <#const _Tp &__value_#>)
//    adjacent_find(<#_ForwardIterator __first#>, <#_ForwardIterator __last#>)
//    for_each(<#_InputIterator __first#>, <#_InputIterator __last#>, <#_Function __f#>)
    //修正算法
//    fill(<#_ForwardIterator __first#>, <#_ForwardIterator __last#>, <#const _Tp &__value_#>)
//    generate(<#_ForwardIterator __first#>, <#_ForwardIterator __last#>, <#_Generator __gen#>)
    //数值算法
    accumulate(<#_InputIterator __first#>, <#_InputIterator __last#>, <#_Tp __init#>)
    inner_product(<#_InputIterator1 __first1#>, <#_InputIterator1 __last1#>, <#_InputIterator2 __first2#>, <#_Tp __init#>)
    partial_sum(<#_InputIterator __first#>, <#_InputIterator __last#>, <#_OutputIterator __result#>)
    //排序，查找算法
    sort(<#_RandomAccessIterator __first#>, <#_RandomAccessIterator __last#>, <#_Compare __comp#>)
    binary_search(<#_ForwardIterator __first#>, <#_ForwardIterator __last#>, <#const _Tp &__value_#>)
    max_element(<#_ForwardIterator __first#>, <#_ForwardIterator __last#>)
    max(<#const _Tp &__a#>, <#const _Tp &__b#>)
    
    return 0;
}
