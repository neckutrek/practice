#ifndef __NECKU_BINARY_TREE_H__
#define __NECKU_BINARY_TREE_H__

#include <memory>

#include "iterator.h"

template <typename T> class TreeNode;

template <typename T>
using TreeNodePtr = typename std::unique_ptr< TreeNode<T> >;

template <typename T>
class TreeNode
{
public:
   T                 m_payload;
   TreeNodePtr<T>    m_sibling;
   TreeNodePtr<T>    m_child;
};

template<typename T>
class Tree
{
public:

   inline size_t        size() {}

   Iterator<T>          top();

private:

   TreeNodePtr<T>       m_root;
   size_t               m_size;

};

#endif