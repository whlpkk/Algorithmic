//
//  MergeSort.swift
//  Heap
//
//  Created by YaoZhiKun on 2017/4/18.
//  Copyright © 2017年 YaoZhiKun. All rights reserved.
//

import Foundation

/*
 归并排序
 1、把序列递归地分成短序列，递归出口是短序列只有1个元素(认为直接有序),然后把各个有序的短序列合并成一个有序的长序列，不断合并直到原序列全部排好序；
 2、合并过程中我们可以保证如果两个当前元素相等时，我们把处在前面的序列的元素保存在结 果序列的前面，这样就保证了稳定性；
 3、稳定排序算法。
 
 时间复杂度：O(n㏒n)，每次2分，总计划分㏒𝑛层子区间，每层复杂度为Θ(𝑛)。
 */

//2路归并
class MergeSort<Element: Comparable> {
    public static func sorted(_ array: [Element]) -> [Element] {
        return sorted(array, by: <)
    }
    public static func sorted(_ array: [Element], by compareOrderBy:(Element, Element) -> Bool) -> [Element] {
        var array = array
        sort(&array, by: compareOrderBy)
        return array
    }

    public static func sort(_ array: inout [Element]) -> Void {
        sort(&array, by: <)
    }
    public static func sort(_ array: inout [Element], by compareOrderBy:(Element, Element) -> Bool) -> Void {
        var tmp :[Element?] = Array(repeating: nil, count: array.count)
        mergeSortAction2(&array, tmp: &tmp, low: 0, high: array.count - 1, by: compareOrderBy)
    }

    // 递归版
    static func mergeSortAction(_ array: inout [Element], tmp: inout [Element?], low: Int, high: Int, by compareOrderBy:(Element, Element) -> Bool) {
        guard low < high else {
            return
        }
        let middle = (high + low) / 2
        mergeSortAction(&array, tmp: &tmp, low: low, high: middle, by: compareOrderBy)
        mergeSortAction(&array, tmp: &tmp, low: middle + 1, high: high, by: compareOrderBy)
        merge(&array, tmp: &tmp, low: low, middle: middle, high: high, by: compareOrderBy)
    }
    
    // 循环版
    static func mergeSortAction2(_ array: inout [Element], tmp: inout [Element?], low: Int, high: Int, by compareOrderBy:(Element, Element) -> Bool) {
        var size = 1 //当前要归并数组的长度
        var l=0, mid=0, r=0
        while size <= high {  //循环依次归并数组前size*2个元素，即前2,4,8,16 ... 个元素
            l = 0
            while l+size <= high {
                mid = l+size-1
                r = mid + size
                if r > high {
                    r = high
                }
                merge(&array, tmp: &tmp, low: l, middle: mid, high: r, by: compareOrderBy)
                l = r + 1
            }
            size *= 2
        }
    }
    
    static func merge(_ array: inout [Element], tmp: inout [Element?], low: Int, middle: Int, high: Int, by compareOrderBy:(Element, Element) -> Bool) {
        for i in low...high {
            tmp[i] = array[i]
        }
        var l = low
        var r = middle + 1
        var pos = low
        while l <= middle || r <= high {
            if r > high || (l<=middle && compareOrderBy(array[l], array[r])) {
                tmp[pos] = array[l]
                l += 1
            } else {
                tmp[pos] = array[r]
                r += 1
            }
            pos += 1
        }
        for i in low...high {
            array[i] = tmp[i]!
        }
    }
}
