//
//  FibonacciSequence.swift
//  Heap
//
//  Created by YaoZhiKun on 2017/4/20.
//  Copyright © 2017年 YaoZhiKun. All rights reserved.
//

import Foundation

//斐波那契数列

//循环算法，时间复杂度比递归小，比递归好
func FibonacciSequence(_ n:Int) -> Int {
    
    if n<=0 {
        return 0
    }
    if n==1 {
        return 1
    }
    
    var sum = 0
    var left = 0
    var right = 1

    for _ in 2...n {
        sum = left + right
        left = right
        right = sum
    }
    return sum
}


//递归算法
func FibonacciSequence2(_ n:Int) -> Int {
    
    if n<=0 {
        return 0
    }
    if n==1 {
        return 1
    }
    
    return FibonacciSequence2(n-2) + FibonacciSequence2(n-1)
}



