#include "catch.hpp"
#include "list.h"

TEST_CASE( "Heap-allocated list", "[heap],[list]" ) {
    
    List<int> list;
    for (int i=0; i<10; ++i)
    {
        list.push_back(i);
    }

    for (int i=0; i<list.size(); ++i)
    {
        REQUIRE( list[i] == i );
    }
}
