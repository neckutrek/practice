#include "catch.hpp"
#include "binary_tree.h"

TEST_CASE( "Binary tree", "[binary-tree]" )
{
    SECTION("single insert")
    {
        BinaryTree<int> bt;
        REQUIRE(bt.size() == 0);
        bt.insert(10);
        REQUIRE(bt.size() == 1);
        REQUIRE(bt.peek() == 10);
    }

    SECTION("multi insert")
    {
        BinaryTree<int> bt;
        bt.insert(10, 20, 30, 40, 50, 15, 25, 35, 45, 55);
        REQUIRE(bt.size() == 10);
    }

    SECTION("delete")
    {
        BinaryTree<int> bt;
        bt.insert(10, 20);
        REQUIRE(bt.size() == 2);
        bt.delete(10);
        REQUIRE(bt.size() == 1);
        REQUIRE(bt.peek() == 20);
    }

    SECTION("find")
    {
        BinaryTree<int> bt;
        bt.insert(10, 20, 30, 40, 50, 15, 25, 35, 45, 55);
        REQUIRE(bt.find(40) == true);
        REQUIRE(bt.find(41) == false);
    }

    SECTION("valid")
    {
        BinaryTree<int> bt;
        bt.insert(10, 20, 30, 40, 50, 15, 25, 35, 45, 55);
        bt.insert(100);
        bt.delete(50);
        REQUIRE(bt.valid());
    }
}
