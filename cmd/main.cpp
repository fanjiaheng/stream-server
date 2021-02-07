/*
 * 主程序
 */

#include <iostream>
#include <memory>
#include <spdlog/spdlog.h>

#include "../stream/Stream.h"
#include "../stream/StreamController.h"


int main(int argc, char** argv)
{
    SPDLOG_INFO("============ stream server ============");

    //启动流媒体服务
    auto stream = std::make_shared<Stream::CStreamController>();
    if (stream == nullptr) {
        SPDLOG_ERROR("create stream service failed.");
        exit(0);
    }
    Stream::IStream* iStream = stream.get();
    iStream->start();

    while (1) {
        /* code */
    }
    
    return 0;
}