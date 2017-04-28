//
//  FindTreeToList.cpp
//  FindTreeToList
//
//  Created by YaoZhiKun on 2017/3/20.
//
//

/*
 题目：输入一棵二元查找树，将该二元查找树转换成一个排序的双向链表。 要求不能创建任何新的结点，只调整指针的指向。

 二元查找树： 它首先要是一棵二元树，在这基础上它或者是一棵空树；或者是具有下列性质的二元树：
 （1）若左子树不空，则左子树上所有结点的值均小于它的父结点的值；
 （2）若右子树不空，则右子树上所有结点的值均大于等于它的根结点的值；
 （3）左、右子树也分别为二元查找树
 
 二元查找树：
      10
     /  \
    6   14
   / \  / \
  4  8 12 16
 
 转化为排序的双向链表： 4=6=8=10=12=14=16
 
 
 
 思路：二元查找树，中序遍历出的正好就是排序后的顺序，需要注意的是修改树的左右节点时会拆散树。
 
 答案：
struct BSTreeNode
{
    int m_nValue; // value of node
    BSTreeNode *m_pLeft; // left child of node
    BSTreeNode *m_pRight; // right child of node
};
BSTreeNode *pHead=NULL;//指向双向链表头结点
BSTreeNode *pIndex=NULL;//指向链表最后一个结点

void convertToDoubleList(BSTreeNode* pBSTree)
{
    if (NULL==pBSTree) {
        return;
    }
    middleOrderBSTree(pBSTree->m_pLeft); //遍历左子树
    
    pBSTree->m_pLeft=pIndex;//使当前结点的左指针指向双向链表中最后一个结点
    if (NULL==pIndex) {
        //若最后一个元素不存在，此时双向链表尚未建立，因此将当前结点设为双向链表头结点
        pHead=pBSTree;
    }else {
        //使双向链表中最后一个结点的右指针指向当前结点
        pIndex->m_pRight=pBSTree;
    }
    pIndex=pBSTree;//将当前结点设为双向链表中最后一个结点
    cout<<pBSTree->m_nValue<<" ";
    
    middleOrderBSTree(pBSTree->m_pRight); //遍历右子树
}
*/


#include "FindTreeToList.h"

#include <iostream>
using namespace std;

struct BSTreeNode
{
    int m_nValue; // value of node
    BSTreeNode *m_pLeft; // left child of node
    BSTreeNode *m_pRight; // right child of node
};

void addBSTreeNode(BSTreeNode *&pCurrent,int value);
void middleOrderBSTree(BSTreeNode* pBSTree);
void convertToDoubleList(BSTreeNode* pCurrent);

BSTreeNode *pHead=NULL;//指向双向链表头结点
BSTreeNode *pIndex=NULL;//指向链表最后一个结点


void findTreeToListTest() {
    //创建查找二元树
    BSTreeNode *pRoot=NULL;
    addBSTreeNode(pRoot,10);
    addBSTreeNode(pRoot,6);
    addBSTreeNode(pRoot,14);
    addBSTreeNode(pRoot,4);
    addBSTreeNode(pRoot,8);
    addBSTreeNode(pRoot,12);
    addBSTreeNode(pRoot,16);
    
    
    middleOrderBSTree(pRoot);
    cout<<"\n\n";
}

// 建立查找二元树
void addBSTreeNode(BSTreeNode *&pCurrent,int value) { //在这个函数中会要改变指针值，一定要记得使用引用传递
    if (pCurrent == NULL) {
        BSTreeNode *rootNode = new BSTreeNode();
        rootNode->m_nValue = value;
        rootNode->m_pLeft = NULL;
        rootNode->m_pRight = NULL;
        pCurrent = rootNode;
    }else if (pCurrent->m_nValue<=value) { //当前节点中的值小于要插入的值，插入右节点
        addBSTreeNode(pCurrent->m_pRight, value);
    }else if (pCurrent->m_nValue>value) {
        addBSTreeNode(pCurrent->m_pLeft, value);
    }
}

// 中序遍历二叉树
void middleOrderBSTree(BSTreeNode* pBSTree)
{
    if (NULL==pBSTree) {
        return;
    }
    if (NULL!=pBSTree->m_pLeft) {
        //遍历左子树，这里可以删掉这个判断
        middleOrderBSTree(pBSTree->m_pLeft);
    }
    
    convertToDoubleList(pBSTree);
    
    if (NULL!=pBSTree->m_pRight){
        //遍历右子树，这里可以删掉这个判断
        middleOrderBSTree(pBSTree->m_pRight);
    }
}

void convertToDoubleList(BSTreeNode* pBSTree)
{
    //注意：这里很重要，因为这里改变了左子树的节点，所以树已经被拆了，所以往后的遍历需要注意。这里因为是中序遍历，所以进入到这里的时候，左子树都是已经被遍历过的，所以修改左子树没有问题，但是如果修改右子树，则会对后面的遍历造成影响，肯定会有问题。
    
    pBSTree->m_pLeft=pIndex;//使当前结点的左指针指向双向链表中最后一个结点
    if (NULL==pIndex)//若最后一个元素不存在，此时双向链表尚未建立，因此将当前结点设为双向链表头结点
    {
        pHead=pBSTree;
    }
    else//使双向链表中最后一个结点的右指针指向当前结点
    {
        pIndex->m_pRight=pBSTree;
    }
    pIndex=pBSTree;//将当前结点设为双向链表中最后一个结点
    cout<<pBSTree->m_nValue<<" ";
}

