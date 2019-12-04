#include "catch.hpp"
#include "array.h"

TEST_CASE( "Stack-allocated array", "[stack],[array]" ) {
    
    Array<int, 10> arr;
    for (int i=0; i<arr.size(); ++i)
    {
        arr[i] = i;
    }

    for (int i=0; i<arr.size(); ++i)
    {
        REQUIRE( arr[i] == i );
    }
}
