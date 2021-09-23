//
//  BuildTree.swift
//  Heap
//
//  Created by YaoZhiKun on 2017/4/18.
//  Copyright © 2017年 YaoZhiKun. All rights reserved.
//

import Foundation

// 二叉树
class BinaryTreeNode<Element: Equatable> {
    var m_value: Element;
    
    var m_left: BinaryTreeNode? = nil
    var m_right: BinaryTreeNode? = nil
    
    init(value: Element) {
        m_value = value
    }
    
    static func getBinaryTree(preOrder:Array<Element>, middleOrder:Array<Element>) -> BinaryTreeNode? {
        guard preOrder.count > 0 else {
            return nil
        }
        
        guard preOrder.count == middleOrder.count else {
            return nil
        }
        let rootValue = preOrder[0]
        
        let root = BinaryTreeNode(value: rootValue)
        if preOrder.count == 1 {
            return root
        }
        
        //在中序遍历中找到根节点的值
        var index = -1
        for (i,item) in middleOrder.enumerated() {
            if item == rootValue {
                index = i
                break
            }
        }
        
        //说明没找到
        if index == -1 {
            return nil
        }
        let length = index
        
        if 1 <= length {
            //左子树的前序遍历数组
            let leftPreOrder = Array(preOrder[1...length])
            //左子树的中序遍历数组
            let leftMiddleOrder = Array(middleOrder[0..<index])
            //构建左子树
            let leftNode = self.getBinaryTree(preOrder: leftPreOrder, middleOrder: leftMiddleOrder)
            root.m_left = leftNode
        }
        
        if index+1<preOrder.count {
            //右子树的前序遍历数组
            let rightPreOrder = Array(preOrder[(index+1)..<preOrder.count])
            //右子树的中序遍历数组
            let rightMiddleOrder = Array(middleOrder[(index+1)..<middleOrder.count])
            //构建右子树
            let rightNode = self.getBinaryTree(preOrder: rightPreOrder, middleOrder: rightMiddleOrder)
            root.m_right = rightNode
        }
        
        return root
    }
    
    public func preOrder() {
        self.preOrderSubTree(root: self)
        print("")
    }
    
    func preOrderSubTree(root:BinaryTreeNode) {
        print(root.m_value, terminator: "  ")
        if let leftNode = root.m_left {
            preOrderSubTree(root: leftNode)
        }
        if let rightNode = root.m_right {
            preOrderSubTree(root: rightNode)
        }
    }
    
    public func midOrder() {
        self.midOrderSubTree(root: self)
        print("")
    }
    
    func midOrderSubTree(root:BinaryTreeNode) {
        if let leftNode = root.m_left {
            midOrderSubTree(root: leftNode)
        }
        print(root.m_value, terminator: "  ")
        if let rightNode = root.m_right {
            midOrderSubTree(root: rightNode)
        }
    }
    
    public func lasOrder() {
        self.lasOrderSubTree(root: self)
        print("")
    }
    
    func lasOrderSubTree(root:BinaryTreeNode) {
        if let leftNode = root.m_left {
            lasOrderSubTree(root: leftNode)
        }
        if let rightNode = root.m_right {
            lasOrderSubTree(root: rightNode)
        }
        print(root.m_value, terminator: "  ")
    }

}
