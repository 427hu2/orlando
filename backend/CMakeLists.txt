cmake_minimum_required(VERSION 3.30)
project(orlando)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_PREFIX_PATH)

if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(CMAKE_PREFIX_PATH "./vcpkg_installed/arm64-osx" CACHE STRING "Set custom prefix path for OSX")
endif()

add_executable(orlando main.cpp)

# Включение тестов
enable_testing()

# Поиск GoogleTest
find_package(GTest CONFIG REQUIRED)

# Сбор тестов
file(GLOB_RECURSE TEST_SOURCES tests/*.cpp) # Рекурсивно ищем все .cpp файлы в папке tests

# Создаем исполняемый файл для тестов
add_executable(orlando_tests ${TEST_SOURCES})

# Линкуем тесты с GTest
target_link_libraries(orlando_tests PRIVATE GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)

# Устанавливаем путь для включаемых файлов, если это требуется
target_include_directories(orlando_tests PRIVATE ${CMAKE_SOURCE_DIR}/tests)

# Регистрируем тесты в CTest
add_test(NAME AllTests COMMAND orlando_tests)