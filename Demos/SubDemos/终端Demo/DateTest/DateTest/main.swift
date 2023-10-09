//
//  main.swift
//  Date
//
//  Created by weijie.zhou on 2023/3/29.
//

import Foundation

extension Array<String> {
    func print() {
        var s = [String]()
        self.forEach { e in
            s.append(e)
        }
        s = s.map { e in
            if e != s.last {
                return e+", "
            } else {
                return e
            }
        }
        var string = ""
        string.append("[")
        s.forEach { s in
            string.append(s)
        }
        string.append("]")
        Swift.print(string)
    }
}

let df = DateFormatter()
//df.eraSymbols.print()
//df.monthSymbols.print()
//df.quarterSymbols.print()
//df.weekdaySymbols.print()
//df.longEraSymbols.print()
//df.shortMonthSymbols.print()
df.shortQuarterSymbols.print()
//df.shortWeekdaySymbols.print()
df.standaloneMonthSymbols.print()
df.standaloneQuarterSymbols.print()
df.standaloneWeekdaySymbols.print()
df.veryShortWeekdaySymbols.print()

