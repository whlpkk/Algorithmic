//
//  BucketSort.swift
//  Heap
//
//  Created by bytedance on 2023/2/1.
//  Copyright © 2023 YaoZhiKun. All rights reserved.
//

import Foundation

/*
 桶排序，是将数据放在几个有序的桶内，将每个桶内的数据进行排序，最后有序地将每个桶中的数据从小到大依次取出，即完成了排序。
 1、设置一个定量的数组当作空桶子（由于桶与桶之间有序，一般使用数组存储m个桶，每个桶又是一个集合）。
 2、寻访序列，并且把项目一个一个放到对应的桶子去。
 3、对每个不是空的桶子进行排序。
 4、从不是空的桶子里把项目再放回原来的序列中。
 
 稳定性：如果使用稳定的内层排序，并且将元素插入桶中时不改变元素间的相对顺序，那么桶排序就是一种稳定的排序算法。本例使用插入排序。此时桶排序是一种稳定的排序算法。
 时间复杂度：受桶内排序算法的影响，如果桶内使用快排，即桶内O(nlogn)。如果要排序的数据有n个，我们把它们分在m个桶中，这样每个桶里的数据就是k = n / m。每个桶内排序的时间复杂度就为O(k*logk)。m个桶就是m * O(k * logk) = m * O( (n/m)*log(n/m) ) = O(nlog(n/m))。 当桶的个数m接近数据个数n时，log（n/m）就是一个较小的常数，所以时间复杂度接近O(n)。
 */

class BucketSort {
    typealias Element = Int
    
    public static func sort(_ array: inout [Element]) {
        sort(&array, by: <)
    }

    public static func sort(_ array: inout [Element], by compareOrderBy:(Element, Element) -> Bool) {
        bucketSort(&array, by: compareOrderBy);
    }

    public static func sorted(_ array: [Element]) -> [Element] {
        return sorted(array, by: <)
    }
    
    public static func sorted(_ array: [Element], by compareOrderBy:(Element, Element) -> Bool) -> [Element] {
        var array = array
        sort(&array, by: compareOrderBy)
        return array
    }
    
    static func bucketSort(_ array: inout [Element], by compareOrderBy:(Element, Element) -> Bool) {
        if array.count <= 1 {
            return
        }
        
        // 确定如何分桶以及桶的数量、这里使用 [min...min+10),[min+10...min+20].... 来分桶。也可以根据实际情况来分
        var max = array[0], min = array[0]
        for elementValue in array {
            if elementValue > max {
                max = elementValue
            } else if elementValue < min {
                min = elementValue
            }
        }
        let bucketNumbs = (max - min)/10 + 1
        
        // 创建桶，寻访序列，并且把元素一个一个放到对应的桶子去。
        var bucketList : [[Element]?] = Array(repeating: nil, count: bucketNumbs)
        for elementValue in array {
            let bucketIndex = (elementValue - min)/10 //确定当前元素应该放入哪个桶
            var bucket = bucketList[bucketIndex] ?? [Element]()
            bucket.append(elementValue)
            bucketList[bucketIndex] = bucket
        }
        
        // 遍历桶数组，对每个不是空的桶子进行排序
        var list = bucketList
        if (compareOrderBy(max,min)) {
            list = bucketList.reversed()
        }
        var index = 0
        for bucket in list {
            guard var bucket = bucket else {
                continue
            }
            // 对桶内的数组进行排序，可以使用各种排序算法，也可以继续使用桶排序（更换桶的分配方式），这里使用插入排序
            InsertSort.sort(&bucket, by: compareOrderBy)
            // 从桶里把元素再放回原来的序列中。
            for e in bucket {
                array[index] = e
                index += 1
            }
        }
    }
}
