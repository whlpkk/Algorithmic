//
//  main.m
//  FindTreeToList
//
//  Created by YaoZhiKun on 2017/3/20.
//
//

#import <Foundation/Foundation.h>
#include "FindTreeToList.h"
#include "MinStack.h"
#include "GreatestSubArraySum.h"
#include "FindPathInTree.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //输入一棵二元查找树，将该二元查找树转换成一个排序的双向链表。 要求不能创建任何新的结点，只调整指针的指向。
        findTreeToListTest();
        
        
        //设计包含min函数的栈。定义栈的数据结构，要求添加一个min函数，能够得到栈的最小元素。要求函数min、push 以及pop 的时间复杂度都是O(1)。
        minStackTest();
        
        
        //输入一个整形数组，数组里有正数也有负数。 数组中连续的一个或多个整数组成一个子数组，每个子数组都有一个和。 求所有子数组的和的最大值。要求时间复杂度为 O(n)。
        GreatestSubArraySumTest();
        
        
        MaxHeap *mHeap;
//        let mHeap = MaxHeap.init(array: [1,332,432,431,12,23,565,89,234,484])
//        print(mHeap.HeapSort())

    }
    return 0;
}



