//
//  QuickSort.swift
//  Heap
//
//  Created by bytedance on 2021/9/22.
//  Copyright © 2021 YaoZhiKun. All rights reserved.
//

import Foundation

/*
 快速排序
 1、挑选基准值：从数列中挑出一个元素，称为“基准”（pivot），
 2、分割：重新排序数列，所有比基准值小的元素摆放在基准前面，所有比基准值大的元素摆在基准后面（与基准值相等的数可以到任何一边）。在这个分割结束之后，对基准值的排序就已经完成，
 3、递归排序子序列：递归地将小于基准值元素的子序列和大于基准值元素的子序列排序。
 4、不稳定的排序算法。
 */

class QuickSort <Element: Comparable> {
    public static func sort(_ array: inout [Element]) {
        sort(&array, by: <)
    }

    public static func sort(_ array: inout [Element], by compareOrderBy:(Element, Element) -> Bool) {
        quickSortUnRecur(&array, low: 0, high: array.count-1, by: compareOrderBy)
//        quickSort(&array, low: 0, high: array.count-1, by: compareOrderBy)
    }

    public static func sorted(_ array: [Element]) -> [Element] {
        return sorted(array, by: <)
    }
    
    public static func sorted(_ array: [Element], by compareOrderBy:(Element, Element) -> Bool) -> [Element] {
        var array = array
        sort(&array, by: compareOrderBy)
        return array
    }
    
    // 递归版
    static func quickSort(_ array: inout [Element], low: Int, high: Int, by compareOrderBy:(Element, Element) -> Bool) {
        guard low<high else {
            return
        }
        //随机选一个基准（pivot），防止原数组本身较有序的情况。只是一个算法的提升，可以不用
        let mid = Int.random(in: low...high)
        swap(&array, mid, low)
        
        var l = low, r = high
        while l<r {
            while l<r && !compareOrderBy(array[r], array[low]) {
                r -= 1
            }
            while l<r && compareOrderBy(array[l], array[low]) {
                l += 1
            }
            swap(&array, l, r)
        }
        swap(&array, low, l)
        quickSort(&array, low: low, high: l, by: compareOrderBy)
        quickSort(&array, low: l+1, high: high, by: compareOrderBy)
    }
    
    // 非递归版
    static func quickSortUnRecur(_ array: inout [Element], low: Int, high: Int, by compareOrderBy:(Element, Element) -> Bool) {
        guard low<high else {
            return
        }
        var list: [(Int,Int)] = []
        list.append((low, high))
        while list.count != 0 {
            let (low, high) = list.remove(at: 0)
            if low >= high {
                continue
            }
            
            //随机选一个基准（pivot），防止原数组本身较有序的情况。只是一个算法的提升，可以不用
            let mid = Int.random(in: low...high)
            swap(&array, mid, low)
            
            var l = low, r = high
            while l<r {
                while l<r && !compareOrderBy(array[r], array[low]) {
                    r -= 1
                }
                while l<r && compareOrderBy(array[l], array[low]) {
                    l += 1
                }
                swap(&array, l, r)
            }
            swap(&array, low, l)
            list.append((low,l))
            list.append((l+1,high))
        }
    }

    
    static func swap(_ array: inout [Element], _ index1: Int, _ index2: Int) {
        (array[index1], array[index2]) = (array[index2], array[index1])
    }
}
