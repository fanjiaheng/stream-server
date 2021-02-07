cmake_minimum_required(VERSION 3.8)


# c++17
set(CMAKE_CXX_STANDARD 17)


# 载入预定义的cmake模块
include(GNUInstallDirs)


# 添加源文件
file(GLOB_RECURSE CMD_SRC_LIST "*.cpp" "*.h")
source_group(cmd FILES ${REALTIME_SRC_LIST})


# 可执行文件
add_executable(${PROJECT_NAME} ${CMD_SRC_LIST})


# spdlog
find_package(spdlog CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE spdlog::spdlog spdlog::spdlog_header_only)


# ffmpeg
#find_package(FFMPEG REQUIRED)
#target_link_libraries(${PROJECT_NAME} PRIVATE ${FFMPEG_LIBRARIES})


# streamService
target_link_libraries(${PROJECT_NAME} PRIVATE streamService)