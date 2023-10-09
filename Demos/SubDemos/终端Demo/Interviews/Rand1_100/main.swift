//
//  main.swift
//
//
//  Created by weijie.zhou on 2023/3/28.
//

import Foundation

func rand2_3() -> Int {
    let value = Int.random(in: 2...3)
    return value
}

func rand2_4() -> Int {
    let value = Int.random(in: 2...4)
    return value
}

func rand2_5() -> Int {
    let value = Int.random(in: 2...5)
    return value
}

func rand1_6() -> Int {
    var results = [Int]()
    let value1_3 = rand2_4() - 1
    let value4_6 = rand2_4() + 2
    results.append(value1_3)
    results.append(value4_6)
    let index = rand2_3() - 2
    return results[index]
}

func rand1_100() -> Int {
    //每个区间随机选择一个数出来
    var results = [Int]()
    var lastEnd = 0
    let offset = 4
    while lastEnd < 100 {
        let value = rand2_5() - 1 + lastEnd
        results.append(value)
        lastEnd += offset
    }
    //将随机选出来的数随机选出一个结果
    var resultsTemp = results
    while results.count > 1 {
        for i in stride(from: 0, to: results.count-1, by: 2) {
            let rand0_1 = rand2_3() - 2
            let index  = i + rand0_1
            if (index != results.count) {
                resultsTemp = resultsTemp.filter{$0 != results[index]}
            }
        }
        results = resultsTemp
    }
    return results[0]
}

func rand1_N(n: Int) -> Int {
    if (n < 2) {return -1}
    if (n == 2) {return rand2_3() - 1}
    if (n == 3) {return rand2_4() - 1}
    
    //每个区间随机选择一个数出来
    var results = [Int]()
    var lastEnd = 0
    let offset = 4
    let tempN = n%4 != 0 ? n/4*4+4 : n
    while lastEnd < tempN {
        let value = rand2_5() - 1 + lastEnd
        if (value <= n) {
            results.append(value)
        }
        lastEnd += offset
    }
    
    //将随机选出来的数随机选出一个结果
    var resultsTemp = results
    while results.count > 1 {
        for i in stride(from: 0, to: results.count-1, by: 2) {
            let rand0_1 = rand2_3() - 2
            let index  = i + rand0_1
            if (index != results.count) {
                resultsTemp = resultsTemp.filter{$0 != results[index]}
            }
        }
        results = resultsTemp
    }
    return results[0]
}

for _ in 1...10 {
//    print("\(rand1_6()),", terminator: "")
//    print("\(rand1_100()),", terminator: "")
    print("\(rand1_N(n: 100)),", terminator: "")
}

