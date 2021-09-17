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
let mHeap:MaxHeap<Int> = MaxHeap.init(array: [1, 32, 42, 3, 12, 23, 56, 89, 24, 44])
print(mHeap.HeapSort())

let minHeap:MinHeap<Int> = MinHeap.init(array: [1, 32, 42, 3, 12, 23, 56, 89, 24, 44])
print(minHeap.HeapSort())
minHeap.push(41)
print(minHeap.HeapSort())


print("归并排序")
//归并排序
let a = [4,2,6,1,3,8,4,9]
let a1 = mergeSort(a)
print(a1)


print("根据前序遍历和中序遍历构建二叉树")
//根据前序遍历和中序遍历构建二叉树
let pre = [1,2,4,7,3,5,6,8]
let mid = [4,7,2,1,5,3,8,6]

let tree = BinaryTreeNode.getBinaryTree(preOrder:pre, middleOrder:mid)
tree?.preOrder()
tree?.midOrder()
tree?.lasOrder()


print("斐波那契数列")
//斐波那契数列
for i in 0...10 {
    print(FibonacciSequence(i), terminator:" ")
}
print("\n")


print("123排序")
let absss = [3,2,1,1,2,3,1,2]
