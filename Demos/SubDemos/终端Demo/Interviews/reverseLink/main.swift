//
//  main.swift
//  reverseLink
//
//  Created by weijie.zhou on 2023/4/10.
//

import Foundation

class Node<T> {
    var value: T
    var next: Node<T>?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
    
    func print() {
        var link: Node<T>? = self
        while(link != nil) {
            Swift.print("\(link!.value),", terminator: "")
            link = link!.next
        }
    }
}

class Stack<T> {
    var values: [T] = []
    var count: Int {
        return values.count
    }
    
    func push(value: T) {
        values.append(value)
    }
    
    func pop() -> T? {
        if let last = values.last {
            values.removeLast()
            return last
        } else {
            return nil
        }
    }
}

func reverseLink<T: Comparable>(link: Node<T>) -> Node<T> {
    var tempLink: Node<T>? = link
    let stack = Stack<Node<T>>()
    while(tempLink != nil) {
        stack.push(value: tempLink!)
        tempLink = tempLink!.next
    }
    let lastNode = stack.pop()
    tempLink = lastNode
    while(tempLink != nil) {
        let node = stack.pop()
        tempLink!.next = node
        tempLink = tempLink?.next
    }
    print("\n")
    lastNode?.print()
    return lastNode!
}

let link = Node(value: 3, next: Node(value: 8, next: Node(value: 5, next: Node(value: 6, next: nil))))
link.print()
let _ = reverseLink(link: link)

