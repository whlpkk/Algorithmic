//
//  main.swift
//  Heap
//
//  Created by YaoZhiKun on 2017/4/17.
//  Copyright © 2017年 YaoZhiKun. All rights reserved.
//

import Foundation

print("堆排序")
//堆，堆排序
let mHeap:Heap<Int> = Heap.init(array: [1, 32, 42, 3, 12, 23, 56, 89, 24, 44], compareOrderBy: >)
print(mHeap.sort())

let minHeap:Heap<Int> = Heap.init(array: [1, 32, 42, 3, 12, 23, 56, 89, 24, 44], compareOrderBy: <)
print(minHeap.sort())
minHeap.push(41)
print(minHeap.sort())

print("\n归并排序")
//归并排序
var a1 = [1, 32, 42, 3, 12, 23, 56, 89, 24, 44]
print( MergeSort.sorted(a1) )
MergeSort.sort(&a1, by: >)
print(a1)

print("\n桶排序")
//桶排序
var a11 = [1, 32, 42, 3, 12, 23, 56, 89, 24, 44]
print( BucketSort.sorted(a11) )
BucketSort.sort(&a11, by: >)
print(a11)

print("\n插入排序")
print( InsertSort.sorted([1, 32, 42, 3, 12, 23, 56, 89, 24, 44], by: >) )
var a2 = [1, 32, 42, 3, 12, 23, 56, 89, 24, 44]
InsertSort.sort(&a2)
print(a2)

print("\n快速排序")
print( QuickSort.sorted([1, 32, 42, 3, 12, 23, 56, 89, 24, 44], by: >) )
var a3 = [1, 32, 42, 3, 12, 23, 56, 89, 24, 44]
QuickSort.sort(&a3)
print(a3)

print("\n选择排序")
print( SelectSort.sorted([1, 32, 42, 3, 12, 23, 56, 89, 24, 44], by: >) )
var a4 = [1, 32, 42, 3, 12, 23, 56, 89, 24, 44]
SelectSort.sort(&a4)
print(a4)

print("\n冒泡排序")
print( BubbleSort.sorted([1, 32, 42, 3, 12, 23, 56, 89, 24, 44], by: >) )
var a5 = [1, 32, 42, 3, 12, 23, 56, 89, 24, 44]
BubbleSort.sort(&a5)
print(a5)


print("\n根据前序遍历和中序遍历构建二叉树")
//根据前序遍历和中序遍历构建二叉树
let pre = [1,2,4,7,3,5,6,8]
let mid = [4,7,2,1,5,3,8,6]

let tree = BinaryTreeNode.getBinaryTree(preOrder:pre, middleOrder:mid)
tree?.preOrder()
tree?.midOrder()
tree?.lasOrder()


print("\n斐波那契数列")
//斐波那契数列
for i in 0...10 {
    print(FibonacciSequence(i), terminator:" ")
}
print("\n")


