cmake_minimum_required(VERSION 3.30)
project(orlando)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_PREFIX_PATH)

if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(CMAKE_PREFIX_PATH "./vcpkg_installed/arm64-osx" CACHE STRING "Set custom prefix path for OSX")
endif()

add_executable(orlando main.cpp)

#enable_testing()
#
#find_package(GTest CONFIG REQUIRED)
#target_link_libraries(orlando PRIVATE GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)
#
#add_test(AllTestsInMain main)