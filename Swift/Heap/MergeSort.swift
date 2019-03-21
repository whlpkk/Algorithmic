//
//  MergeSort.swift
//  Heap
//
//  Created by YaoZhiKun on 2017/4/18.
//  Copyright © 2017年 YaoZhiKun. All rights reserved.
//

import Foundation

//2路归并

func mergeSort(_ array: [Int]) -> [Int] {
    var helper = Array(repeating: 0, count: array.count)
    var array = array
    mergeSort(&array, helper: &helper, low: 0, high: array.count - 1)
    return array
}

func mergeSort(_ array: inout [Int], helper: inout [Int], low: Int, high: Int) {
    guard low < high else {
        return
    }
    let middle = (high - low) / 2 + low
    mergeSort(&array, helper: &helper, low: low, high: middle)
    mergeSort(&array, helper: &helper, low: middle + 1, high: high)
    merge(&array, helper: &helper, low: low, middle: middle, high: high)
}

func merge(_ array: inout [Int], helper: inout [Int], low: Int, middle: Int, high: Int) {
    for i in low...high {
        helper[i] = array[i]
    }
    var helperLeft = low
    var helperRight = middle + 1
    var current = low
    while helperLeft <= middle && helperRight <= high {
        if helper[helperLeft] <= helper[helperRight] {
            array[current] = helper[helperLeft]
            helperLeft += 1
        } else {
            array[current] = helper[helperRight]
            helperRight += 1
        }
        current += 1
    }
    guard middle - helperLeft >= 0 else {
        return
    }
    for i in 0...middle - helperLeft {
        array[current + i] = helper[helperLeft + i]
    }
}
