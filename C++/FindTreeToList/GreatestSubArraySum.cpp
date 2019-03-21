//
//  GreatestSubArraySum.cpp
//  FindTreeToList
//
//  Created by YaoZhiKun on 2017/3/20.
//
//


/*
 题目:输入一个整形数组，数组里有正数也有负数。 数组中连续的一个或多个整数组成一个子数组，每个子数组都有一个和。 求所有子数组的和的最大值。要求时间复杂度为 O(n)。
 例如输入的数组为 1, -2, 3, 10, -4, 7, 2, -5，和最大的子数组为 3, 10, -4, 7, 2， 因此输出为该子数组的和 18。
 
 思路：保存当前的和值，如果小于0，则放弃，重新开始。
 答案：
*/

#include "GreatestSubArraySum.h"
#include<iostream>
using namespace std;

int findGreatestSubSum(const int a[],const int size){
    int curSum=0;
    int maxSum=0;
    for(int i=0;i<size;i++){
        curSum+=a[i];
        if(curSum<0) curSum=0;           //放弃这个阶段，从新开始
        if(curSum>maxSum) maxSum=curSum; //更新最大和
    }
    if(maxSum==0){            //若是数组中的元素均为负数，则输出里面的最大元素
        maxSum=a[0];          //当然这步也可以写到上面一个循环里
        for(int i=1;i<size;i++){
            if(maxSum<a[i]) maxSum=a[i];
        }
    }
    return maxSum;
}

void GreatestSubArraySumTest() {
    int a[10]={1, -2, 3, 10, -4, 7, 2, -5};
    cout<<findGreatestSubSum(a,10)<<"\n\n";
}
