cmake_minimum_required(VERSION 3.8)

set(CMAKE_CXX_STANDARD 17)

file(GLOB_RECURSE STREAM_SERVICE_SRC_LIST "*.cpp" "*.h")

add_library(streamService STATIC ${STREAM_SERVICE_SRC_LIST})

# spdlog
find_package(spdlog CONFIG REQUIRED)
target_link_libraries(streamService PRIVATE spdlog::spdlog spdlog::spdlog_header_only)


# 配置编译的头文件
target_include_directories(streamService PUBLIC ${CMAKE_CURRENT_LIST_DIR})


# 设置编译选项
target_compile_options(streamService PRIVATE "$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:CXX>>:/utf-8>")
target_compile_options(streamService PRIVATE "$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:CXX>>:/MP>")