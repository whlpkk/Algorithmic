//
//  SelectSort.swift
//  Heap
//
//  Created by bytedance on 2021/9/22.
//  Copyright © 2021 YaoZhiKun. All rights reserved.
//

import Foundation

/*
 选择排序
 1、每个位置选择当前元素最小的；

 不稳定的排序算法。
 举个例子，序列5 8 5 2 9， 我们知道第一遍选择第1个元素5会和2交换，那么原序列中2个5的相对前后顺序就被破坏了；
 */

class SelectSort<Element: Comparable> {
    public static func sort(_ array: inout [Element]) {
        sort(&array, by: <)
    }

    public static func sort(_ array: inout [Element], by compareOrderBy:(Element, Element) -> Bool) {
        for i in 0..<array.count-1 {
            var target = i
            for j in i+1..<array.count {
                if compareOrderBy(array[j], array[target]) {
                    target = j
                }
            }
            swap(&array, i, target)
        }
    }

    public static func sorted(_ array: [Element]) -> [Element] {
        return sorted(array, by: <)
    }
    
    public static func sorted(_ array: [Element], by compareOrderBy:(Element, Element) -> Bool) -> [Element] {
        var array = array
        sort(&array, by: compareOrderBy)
        return array
    }
    
    
    static func swap(_ array: inout [Element], _ index1: Int, _ index2: Int) {
        (array[index1], array[index2]) = (array[index2], array[index1])
    }

}
