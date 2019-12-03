set(SOURCES
   main.cpp
   test_array.cpp)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin/test)
add_executable(tests ${SOURCES})
target_include_directories(tests PRIVATE ${PROJECT_SOURCE_DIR}/include)
