set(SOURCES
   main.cpp)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
add_executable(main ${SOURCES})
target_include_directories(main PRIVATE ${PROJECT_SOURCE_DIR}/include)
