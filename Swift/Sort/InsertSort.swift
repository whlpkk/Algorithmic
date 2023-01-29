//
//  InsertSort.swift
//  Heap
//
//  Created by bytedance on 2021/9/18.
//  Copyright © 2021 YaoZhiKun. All rights reserved.
//

import Foundation

/*
 插入排序
 1、在已经有序的小序列的基础上，一次插入一个元素；
 2、想要插入的元素和已经有序的最大者开始比起，如果比它大则直接插入在其后面，否则一直往前找直到找到它该插入的位置；（由于数组是连续的数据结构，所以插入操作需要移动很多元素，这里使用冒泡）
 3、如果碰见一个和插入元素相 等的，那么插入元素把想插入的元素放在相等元素的后面；
 4、相等元素的前后顺序没有改变；
 5、稳定排序算法。
 
 时间复杂度：O(n)~O(n²)，平均时间复杂度为O(n²)。
 在完全有序的情况下，插入排序每个未排序区间元素只需要比较1次，所以时间复杂度是O(n)。
 而在极端情况完全逆序，时间复杂度为O(n²).
 */

class InsertSort <Element: Comparable> {
    
    public static func sort(_ array: inout [Element]) {
        sort(&array, by: <)
    }

    public static func sort(_ array: inout [Element], by compareOrderBy:(Element, Element) -> Bool) {
        for i in 1..<array.count {
            //将a[i]插入到a[i-1]，a[i-2] ... a[0]之中
            for j in (1...(i)).reversed() {  //由于a[0],a[1]...a[i-1]已经有序，所以j从i开始冒泡，即可调整好i的位置
                if compareOrderBy(array[j], array[j-1]) {
                    swap(&array, j-1, j)
                } else {
                    break
                }
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
