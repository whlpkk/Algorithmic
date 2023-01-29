//
//  Heap.swift
//  Heap
//
//  Created by YaoZhiKun on 2017/4/17.
//  Copyright © 2017年 YaoZhiKun. All rights reserved.
//

import Foundation

/*
 堆排序可以被认为是一种改进的选择排序：就像选择算法一样，它将输入分成已排序的和还未排序的区域，它通过提取未排序的区域内最大的元素并将其移动到已排序的区域来迭代缩小未排序的区域。堆排序相对选择排序改进的部分包括使用堆数据结构而不是线性时间的搜索来找到最大值。
 
 堆：堆可以被看作是一棵树，堆中某个节点的值总是不大于或不小于其父节点的值。堆的实现通常是通过构造二叉堆实现。而且因为二叉堆的应用很普遍，当不加限定时，堆通常指的就是二叉堆。二叉堆一般分为两种：大顶堆小顶堆。
 大顶堆：堆中的最大元素在根结点（堆顶）；堆中每个父节点的元素值都大于等于其子结点（如果子节点存在）
 小顶堆：堆中的最小元素出现在根结点（堆顶）；堆中每个父节点的元素值都小于等于其子结点（如果子节点存在）
 
 
 1、输入：一系列的无序元素（比如说，数字）组成的输入数组A
 2、经过：堆排序的过程可以具体分为三步，创建堆，调整堆，堆排序。
 创建堆，以数组的形式将堆中所有的数据重新排序，使其成为大顶堆/小顶堆。
 调整堆，调整过程需要保证堆序性质：在一个二叉堆中任意父节点大于其子节点。
 堆排序，取出位于堆顶的第一个数据（大顶堆则为最大数，小顶堆则为最小数），放入输出数组B 中，再将剩下的顶作调整堆的迭代/重复运算直至输入数组 A中只剩下最后一个元素。
 3、输出：输出已经按照要求排好了顺序的数组B。
 
 调整堆：大顶堆小顶堆，push或pop的重要操作，即 上浮 和 下沉
 当需要push时， 先append到最后，然后执行  上浮
 当需要pop时，交互根节点和最后一个叶子节点，推出根节点，将根部的叶子节点  下沉
 
 不稳定的排序算法。
 时间复杂度：O(𝑛㏒𝑛)
 */

public protocol Copyable {
    func copy() -> Copyable
}

extension Heap :Copyable {
    public func copy() -> Copyable {
        let clas = type(of: self)
        let heap = clas.init(array: self.array, compareOrderBy: self.compareOrderFunc)
        return heap
    }
}

class Heap <Element: Comparable> {
    public var array:Array<Element> = []
    let compareOrderFunc : ((Element, Element) -> Bool)
    
    //如果没有左节点，返回-1
    public func left(_ index:Int) -> Int {
        let i = (index+1)*2 - 1 //如果下标是从1开始 则是 index*2
        guard i < self.array.count else {
            //如果越界，返回-1
            return -1
        }
        return i
    }
    
    //如果没有右节点，返回-1
    public func right(_ index:Int) -> Int {
        let i = (index+1)*2+1 - 1 //如果下标是从1开始 则是 index*2+1
        guard i < self.array.count else {
            //如果越界，返回-1
            return -1
        }
        return i
    }
    
    //如果没有父节点，返回-1
    public func parent(_ index:Int) -> Int {
        guard !self.isEmpty() else {
            return -1
        }
        return (index+1)/2 - 1 //如果下标是从1开始 则是 index/2
    }
    
    public func isEmpty() -> Bool {
        return self.array.count == 0
    }
    
    public func count() -> Int {
        return self.array.count
    }
    
    public func root() -> Element? {
        guard !self.isEmpty() else {
            return nil
        }
        return self.array[0]
    }
    
    //向堆中插入一个值
    public func push(_ element:Element) {
        //在尾部插入一个节点
        self.array.append(element)
        
        //上浮这个节点
        self.shiftUp(self.array.count-1);
    }
    
    public func pop() -> Element? {
        guard self.array.count > 0 else {
            return nil
        }
        
        let count = self.array.count-1
        let e = self.array[0]
        //交换最后一个节点和第一个节点
        self.swap(0, count)
        //删除最后一个节点
        self.array.removeLast()
        //下沉交换后的第一个节点
        self.shiftDown(0)
        return e
    }
    
    //交互两个节点的值
    func swap(_ indexA:Int, _ indexB:Int) {
        guard indexA>=0 && indexA<self.array.count else {
            return
        }
        guard indexB>=0 && indexB<self.array.count else {
            return
        }
        (self.array[indexA], self.array[indexB]) = (self.array[indexB], self.array[indexA])
    }
    
    func isNeedChange(_ index: Int, _ parent: Int) -> Bool {
        let i = compareElement(parentIndex: parent, leftIndex: index, rightIndex: nil)
        return !(i == parent)
    }
    func compareElement(parentIndex:Int, leftIndex:Int, rightIndex:Int?) -> Int {
        var targetIndex = parentIndex
        
        if leftIndex != -1 &&  self.compareOrderFunc(self.array[leftIndex], self.array[targetIndex]) {
            targetIndex = leftIndex
        }
        guard let rightIndex = rightIndex else {
            return targetIndex
        }
        if rightIndex != -1 && self.compareOrderFunc(self.array[rightIndex], self.array[targetIndex]) {
            targetIndex = rightIndex
        }
        return targetIndex
    }

    //使index节点上浮
    func shiftUp(_ index:Int) {
        guard index>=0 && index<self.array.count else {
            return
        }
        
        var child = index
        var parent = self.parent(child)
        while parent != -1 {
            guard self.isNeedChange(child, parent) else {
                break
            }
            self.swap(child, parent)
            child = parent
            parent = self.parent(parent)
        }
    }
    
    //使index节点下沉
    func shiftDown(_ index:Int) {
        self.shiftDownRecursive(index)
        //self.shiftDownCycle(index)
    }
    
    //节点下沉递归版
    func shiftDownRecursive(_ index:Int) {
        let l = self.left(index)
        let r = self.right(index)
        let largest = self.compareElement(parentIndex: index, leftIndex: l, rightIndex: r)
        if index != largest {
            self.swap(index, largest)
            self.shiftDownRecursive(largest)
        }
    }
    
    //节点下沉循环版
    func shiftDownCycle(_ index:Int) {
        guard index>=0 && index<self.array.count else {
            return
        }

        var index = index
        var l = self.left(index)
        var r = self.right(index)
        
        while true {
            let largest = self.compareElement(parentIndex: index, leftIndex: l, rightIndex: r)
            if index != largest {
                self.swap(index, largest)
            }else {
                break; //退出循环
            }
            l = self.left(largest)
            r = self.right(largest)
            index = largest
        }
    }
        
    required init(array:Array<Element>?, compareOrderBy: @escaping (Element, Element) -> Bool) {
        self.compareOrderFunc = compareOrderBy
        //两种建堆方法，第一种是全部放入，然后不断调整
        //self.buildHeap(array: array ?? [])
        //第二种是一个个插入堆中
        self.buildHeap2(array: array ?? [])
    }
    
    //建堆，从最后一个非叶子节点开始，依次向前下沉节点,从后向前建堆。
    //最后一个非叶子节点，也即是最后一个节点的父节点
    public func buildHeap(array:Array<Element>) {
        self.array = array
        guard array.count>0 else {
            return
        }
        let lastParent = self.parent(array.count-1)
        if lastParent == -1 {
            //说明没有非叶子节点，也即此时只有一个根节点
            return
        }
        for i in (0...lastParent).reversed() {
            self.shiftDown(i)
        }
    }
    
    //第二种建堆方法，直接一个一个push
    public func buildHeap2(array:Array<Element>) {
        guard array.count>0 else {
            return
        }
        for e in array {
            self.push(e)
        }
    }
    
    public func sort() -> Array<Element> {
        var resArray: Array<Element> = [];
        
        let temHeap = self.copy() as! Heap
        while !temHeap.isEmpty() {
            let e = temHeap.pop()
            resArray.append(e!)
        }
        return resArray
    }
}
