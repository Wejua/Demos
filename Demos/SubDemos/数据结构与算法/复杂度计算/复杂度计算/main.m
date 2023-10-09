//
//  main.m
//  复杂度计算
//
//  Created by 周位杰 on 2022/3/26.
//

#import <Foundation/Foundation.h>
#include <malloc/malloc.h>

#pragma mark - 时间复杂度
// 1 + 1，O(1)
void test1(int n) {
    int sum = 0;              //1
    sum = (n + 1) * n / 2;      //1
}

// 1 + log2(n)，O(logn)
void test2(int n) {
    int count = 1;              // 1
    while (count < n) {
        count = count * 2;      // log2(n)
    }
}

// 1 + 3n，O(n)
void test3(int n) {
    for (int i = 0; i < n; i++) {   //1 + n + n
        n = n + 1;                  //n
    }
}

// log5(n), O(logn)
void test4(int n) {
    while ((n = n / 5) > 0) {
        printf("%d", n);      // log5(n)
    }
}

// 1 + 2log2(n) + log2(n) * (1 + 3n)
// 1 + 3log2(n) + 3nlog2(n), O(nlog(n))
void test5(int n) {
    for (int i = 0; i < n; i += i) { // 1 + log2(n) + log2(n)。i+=i 等于 i=i+i 等于 i=2*i
        // 1 + 3n
        for (int j = 0; j < n; j++) {
            printf("%d", n);
        }
    }
}

// 1 + 2n + n * (1 + n + n + n) = 1 + 3n + 3n^2, O(n^2)
void test6(int n) {
    for (int i = 0; i < n; i++) { // 1 + n + n
        for (int j = 0; j < n; j++) { // n * (1 + n + n)
            printf("%d", n);          //n * n
        }
    }
}

#pragma mark - 空间复杂度
//上面时间复杂度的方法都是只创建了i变量和j变量, 所以复杂度都是O(1)

// 1 + n + 1, O(n)
void test7(int n) {
    int a = 10;                             //1
    int *arr = malloc(sizeof(int) * n);     //n
    for (int i = 0; i < n; i++) {           //1
        printf("%d, %d, %p\n", n, a, arr);
    }
}

//斐波那契数列复杂度
//0,1,1,2,3,5,8,13...
//详细解释：https://blog.csdn.net/superwangxinrui/article/details/79626870

//时间复杂度:O(n^2), 空间复杂度:O(n)，空间复杂度不确定
int fib(int n) {
    if (n <= 1) return n;
    return fib(n-1) + fib(n-2);
}

//时间复杂度:O(n), 空间复杂度:O(1)
int fib2(int index) {
    if (index <= 1) return index;
    int first = 0;
    int second = 1;
    for (int startIndex = 2; startIndex <= index; startIndex++) {
        int sum = first + second;  //虽然每次执行都开辟一个sum变量，但是离开作用域会释放，没有累加起来
        first = second;
        second = sum;
    }
    printf("sum: %d\n", second);
    return second;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test7(3);
    }
    return 0;
}
