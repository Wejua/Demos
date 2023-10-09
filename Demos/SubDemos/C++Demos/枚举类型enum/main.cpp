//
//  main.cpp
//  枚举类型enum
//
//  Created by 周位杰 on 2022/4/21.
//

#include <iostream>

using namespace std;

//枚举默认值时从0开始逐个递增，也可以赋指定值
enum Direction {
    up,
    lefte,
    down = 100,
    righte,
};

void print_direction(Direction d);

int main(int argc, const char * argv[]) {
    //可以直接访问
    cout << up << endl;
    cout << down << endl;
    
    print_direction(down);
    
    return 0;
}

void print_direction(Direction d) {
    switch (d) {
        case up:
            cout << "up" << endl;
            break;
        case lefte:
            cout << "left" << endl;
            break;
        case down:
            cout << "down" << endl;
            break;
        case righte:
            cout << "right" << endl;
            break;
        default:
            break;
    }
}
