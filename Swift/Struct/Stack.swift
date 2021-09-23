//
//  Stack.swift
//  Heap
//
//  Created by bytedance on 2021/9/22.
//  Copyright © 2021 YaoZhiKun. All rights reserved.
//

import Foundation

public class Stack<Element> {
    var list = [Element]()
    
    public func push(_ e: Element) {
        list.append(e)
    }

    public func push(_ e: inout Element) {
        list.append(e)
    }
    
    public func pop() -> Element? {
        guard !isEmpty() else {
            return nil
        }
        return list.removeLast()
    }
    
    public func popAll() {
        return list.removeAll()
    }
    
    public func isEmpty() -> Bool {
        return list.count == 0
    }
    
    public func top() -> Element? {
        return list.last
    }
    
}

public extension Stack where Element:Equatable {
    func contains(_ e: Element) -> Bool {
        return list.contains(e)
    }
}
