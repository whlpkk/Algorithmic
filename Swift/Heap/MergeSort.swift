//
//  MergeSort.swift
//  Heap
//
//  Created by YaoZhiKun on 2017/4/18.
//  Copyright © 2017年 YaoZhiKun. All rights reserved.
//

import Foundation

//2路归并

class MergeSort<Element: Comparable> {
    public static func mergeSorted(_ array: [Element]) -> [Element] {
        var tmp :[Element?] = Array(repeating: nil, count: array.count)
        var array = array
        mergeSortAction2(&array, tmp: &tmp, low: 0, high: array.count - 1)
        return array
    }
    
    public static func mergeSort(_ array: inout [Element]) -> Void {
        var tmp :[Element?] = Array(repeating: nil, count: array.count)
        mergeSortAction2(&array, tmp: &tmp, low: 0, high: array.count - 1)
    }

    // 递归版
    static func mergeSortAction(_ array: inout [Element], tmp: inout [Element?], low: Int, high: Int) {
        guard low < high else {
            return
        }
        let middle = (high - low) / 2 + low
        mergeSortAction(&array, tmp: &tmp, low: low, high: middle)
        mergeSortAction(&array, tmp: &tmp, low: middle + 1, high: high)
        merge(&array, tmp: &tmp, low: low, middle: middle, high: high)
    }
    
    // 循环版
    static func mergeSortAction2(_ array: inout [Element], tmp: inout [Element?], low: Int, high: Int) {
        var size = 1
        var l=0, mid=0, r=0
        while size <= high {
            l = 0
            while l+size <= high {
                mid = l+size-1
                r = mid + size
                if r > high {
                    r = high
                }
                merge(&array, tmp: &tmp, low: l, middle: mid, high: r)
                l = r + 1
            }
            size *= 2
        }
    }
    
    static func merge(_ array: inout [Element], tmp: inout [Element?], low: Int, middle: Int, high: Int) {
        for i in low...high {
            tmp[i] = array[i]
        }
        var l = low
        var r = middle + 1
        var i = low
        while l <= middle || r <= high {
            if r > high || (l<=middle && array[l] <= array[r]) {
                tmp[i] = array[l]
                l += 1
            } else {
                tmp[i] = array[r]
                r += 1
            }
            i += 1
        }
        for i in low...high {
            array[i] = tmp[i]!
        }
    }
}
