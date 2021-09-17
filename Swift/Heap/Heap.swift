//
//  Heap.swift
//  Heap
//
//  Created by YaoZhiKun on 2017/4/17.
//  Copyright © 2017年 YaoZhiKun. All rights reserved.
//

import Foundation

/*
 大顶堆小顶堆，push或pop的重要操作，即 上浮 和 下沉
 当需要push时， 先append到最后，然后执行  上浮
 当需要pop时，交互根节点和最后一个叶子节点，推出根节点，将根部的叶子节点  下沉
 */


public protocol Copyable {
    func copy() -> Copyable
}

extension HeapClass :Copyable {
    public func copy() -> Copyable {
        let clas = type(of: self)
        let heap = clas.init(array: self.array)
        return heap
    }
}

public protocol HeapComparable {
    func compareElement(parentIndex:Int, leftIndex:Int, rightIndex:Int?) -> Int
    func isNeedChange(_ index: Int, _ parent: Int) -> Bool
}

extension HeapComparable {
    func isNeedChange(_ index: Int, _ parent: Int) -> Bool {
        let i = compareElement(parentIndex: parent, leftIndex: index, rightIndex: nil)
        return !(i == parent)
    }
}

typealias Heap<Element: Comparable> = HeapClass<Element> & HeapComparable

class HeapClass <Element: Comparable> {
    public var array:Array<Element> = []
    
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

    //使index节点上浮
    func shiftUp(_ index:Int) {
        guard index>=0 && index<self.array.count else {
            return
        }
        
        var parent = self.parent(index)
        while parent != -1 {
            guard let heap = self as? Heap<Element> else {
                return
            }

            guard heap.isNeedChange(index, parent) else {
                break
            }
            self.swap(index, parent)
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
        guard index>=0 && index<self.array.count else {
            return
        }
        guard let heap = self as? Heap<Element> else {
            return
        }

        let l = self.left(index)
        let r = self.right(index)
        let largest = heap.compareElement(parentIndex: index, leftIndex: l, rightIndex: r)
        if index != largest {
            self.swap(index, largest)
            self.shiftDownRecursive(largest)
        }
    }
    //节点下沉循环版
    public func shiftDownCycle(_ index:Int) {
        guard index>=0 && index<self.array.count else {
            return
        }
        guard let heap = self as? Heap<Element> else {
            return
        }

        var index = index
        var l = self.left(index)
        var r = self.right(index)
        
        while true {
            let largest = heap.compareElement(parentIndex: index, leftIndex: l, rightIndex: r)
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
    
    required init(array:Array<Element>?) {
        //两种建堆方法，第一种是全部放入，然后不断调整
        self.buildHeap(array: array != nil ? array! : [])
        //第二种是一个个插入堆中
        //self.buildHeap2(array: array)
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
    
    
    public func HeapSort() -> Array<Element> {
        var resArray: Array<Element> = [];
        
        let temHeap = self.copy() as! HeapClass
        while !temHeap.isEmpty() {
            let e = temHeap.pop()
            resArray.append(e!)
        }
        return resArray
    }
    
}

class MaxHeap<Element: Comparable>: Heap<Element> {
    //小顶堆同理self.array[l] > self.array[largest]，把'>'替换成'<'即可
    public func compareElement(parentIndex:Int, leftIndex:Int, rightIndex:Int?) -> Int {
        var largest = parentIndex
        
        if leftIndex != -1 && self.array[leftIndex] > self.array[largest] {
            largest = leftIndex
        }
        guard let rightIndex = rightIndex else {
            return largest
        }
        if rightIndex != -1 && self.array[rightIndex] > self.array[largest] {
            largest = rightIndex
        }
        return largest
    }
}

class MinHeap<Element: Comparable>: Heap<Element> {
    public func compareElement(parentIndex:Int, leftIndex:Int, rightIndex:Int?) -> Int {
        var min = parentIndex
        
        if leftIndex != -1 && self.array[leftIndex] < self.array[min] {
            min = leftIndex
        }
        guard let rightIndex = rightIndex else {
            return min
        }
        if rightIndex != -1 && self.array[rightIndex] < self.array[min] {
            min = rightIndex
        }
        return min
    }
}
