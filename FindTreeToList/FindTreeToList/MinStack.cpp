//
//  MinStack.cpp
//  FindTreeToList
//
//  Created by YaoZhiKun on 2017/3/20.
//
//

/*
 题目：设计包含min函数的栈。定义栈的数据结构，要求添加一个min 函数，能够得到栈的最小元素。要求函数min、push 以及pop 的时间复杂度都是O(1)。
 解法：定义栈元素，每个栈元素含有当前的最小值即可。
      解法二，再维护一个最小值栈，每次入栈时，判断当前值如果小于等于 最小值栈顶元素，最小值栈就入栈。出栈时，判断如果等于 最小值栈栈顶元素，最小值栈就出栈。获取最小值时只需要去最小值栈顶元素即可。
 
 答案如下：
 */


#include "MinStack.h"
#include <stdlib.h>
#include <iostream>

struct MinStackElement {
    int data;
    int min;
};

struct MinStack {
    MinStackElement *elements;
    int size;
    int top;
};

MinStack* MinStackInit(int maxSize);
void MinStackFree(MinStack *stack);
void MinStackPush(MinStack *stack, int d);
int MinStackPop(MinStack *stack);
bool MinStackEmpty(MinStack *stack);
bool MinStackFull(MinStack *stack);
int MinStackMin(MinStack *stack);

MinStack* MinStackInit(int maxSize) {
    MinStack *stack = new MinStack();
    stack->size = maxSize;
    stack->elements = (MinStackElement*) malloc(sizeof(MinStackElement)*maxSize);
    stack->top = 0;
    return stack;
}
void MinStackFree(MinStack *stack) {
    free(stack->elements);
}

void MinStackPush(MinStack *stack, int d) {
    if (MinStackFull(stack)) {
        std::cout<<"栈已满\n";
        return;
    }
    MinStackElement *p = &stack->elements[stack->top];
    p->data = d;
    p->min = (stack->top==0 ? d : stack->elements[stack->top-1].min);
    
    if (p->min > d) {
       p->min = d;
    }
    stack->top++;
}

int MinStackPop(MinStack *stack) {
    if (MinStackEmpty(stack)) {
        std::cout<<"栈已空\n";
        return -1;
    }
    return stack->elements[--stack->top].data;
}

int MinStackMin(MinStack *stack) {
    if (MinStackEmpty(stack)) {
        std::cout<<"栈已空\n";
        return -1;
    }
    return stack->elements[stack->top-1].min;
}

bool MinStackEmpty(MinStack *stack) {
    return stack->top==0;
}
bool MinStackFull(MinStack *stack) {
    return stack->top==stack->size;
}


//测试结果
void minStackTest() {
    MinStack *stack = MinStackInit(10);
    MinStackPush(stack, 100);
    MinStackPush(stack, 35);
    MinStackPush(stack, 10);
    MinStackPush(stack, 22);
    MinStackPush(stack, 9);
    MinStackPush(stack, 64);
    MinStackPush(stack, 1);
    MinStackPush(stack, 77);
    MinStackPush(stack, 111);
    MinStackPush(stack, 42);
    MinStackPush(stack, 53);
    MinStackPush(stack, 42);
    MinStackPush(stack, 42);
    
    do {
        std::cout<<"当前最小值： "<<MinStackMin(stack)<<"\n";
        MinStackPop(stack);
    } while ( !MinStackEmpty(stack) );
    std::cout<<"\n";
}




