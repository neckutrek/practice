cmake_minimum_required(VERSION 3.15)

set(CMAKE_C_COMPILER "/usr/bin/clang")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++")

project(dalg)

set( CMAKE_CXX_FLAGS "-Wpedantic -Wall -O3 -std=c++17" )

add_subdirectory(${PROJECT_SOURCE_DIR}/src)