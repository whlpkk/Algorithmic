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
 1、选择排序是一种简单直观的排序算法。它的工作原理是：第一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，然后再从剩余的未排序元素中寻找到最小（大）元素，然后放到已排序的序列的末尾。以此类推，直到全部待排序的数据元素的个数为零。
 2、不稳定的排序算法。
 
 时间复杂度：O(n²)
 比较次数为 (n-1)+(n-2)+...+1 = n*(n-1)/2，即O(n²)
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
