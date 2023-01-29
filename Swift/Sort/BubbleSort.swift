//
//  BubbleSort.swift
//  Heap
//
//  Created by bytedance on 2021/9/22.
//  Copyright © 2021 YaoZhiKun. All rights reserved.
//

import Foundation

/*
 冒泡排序
 1、它重复地走访过要排序的元素列，依次比较两个相邻的元素，如果顺序错误就把他们交换过来。走访元素的工作是重复地进行，直到没有相邻元素需要交换，也就是说该元素列已经排序完成。
 2、冒泡排序是一种稳定排序算法。冒泡排序就是把小的元素往前调或者把大的元素往后调。比较是相邻的两个元素比较，交换也发生在这两个元素之间。所以，如果两个元素相等，是不会再交换的；如果两个相等的元素没有相邻，那么即使通过前面的两两交换把两个相邻起来，这时候也不会交换，所以相同元素的前后顺序并没有改变。

 时间复杂度：O(n)~O(n²)，平均时间复杂度为O(n²)。
 若文件的初始状态是正序的，一趟扫描即可完成排序。所以，冒泡排序最好的时间复杂度为O(n)
 若初始文件是反序的，需要进行n-1趟排序。每趟排序要进行n-i次关键字的比较(1≤i≤n-1)，比较次数为 (n-1)+(n-2)+...+1 = n*(n-1)/2，即O(n²)
 */

class BubbleSort <Element: Comparable> {
    public static func sort(_ array: inout [Element]) {
        sort(&array, by: <)
    }

    public static func sort(_ array: inout [Element], by compareOrderBy:(Element, Element) -> Bool) {
        for i in 0..<array.count-1 {
            var swaped = false
            for j in 1..<array.count-i {
                if compareOrderBy(array[j], array[j-1]) {
                    swap(&array, j-1, j)
                    swaped = true
                }
            }
            if !swaped {
                break
            }
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
