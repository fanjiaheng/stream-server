
# 检查cmake的版本最低版本
cmake_minimum_required(VERSION 3.8)


# 项目信息
project( stream_server
         VERSION 0.1.0
         DESCRIPTION "project based on ffmpeg"
         HOMEPAGE_URL "https://github.com/fanjiaheng/stream-server"
         LANGUAGES CXX
        )
message( STATUS "CMAKE_PROJECT_NAME = ${CMAKE_PROJECT_NAME}" )
message( STATUS "PROJECT_VERSION_MAJOR = ${PROJECT_VERSION_MAJOR}" )
message( STATUS "PROJECT_VERSION_MINOR = ${PROJECT_VERSION_MINOR}" )
message( STATUS "PROJECT_VERSION_PATCH = ${PROJECT_VERSION_PATCH}" )
message( STATUS "PROJECT_VERSION_TWEAK = ${PROJECT_VERSION_TWEAK}" )
message( STATUS "PROJECT_HOMEPAGE_URL = ${PROJECT_HOMEPAGE_URL}")
message( STATUS "CMAKE_PROJECT_DESCRIPTION = ${CMAKE_PROJECT_DESCRIPTION}" )


# 添加子项目的目录
add_subdirectory(stream)
add_subdirectory(cmd)


# 安装
#install(TARGETS ${PROJECT_NAME}
#    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} # 可执行文件安装路径
#    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} # 动态库安装路径
#    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} # 静态库安装路径
#    OBJECTS DESTINATION ${CMAKE_INSTALL_LIBDIR}
#)