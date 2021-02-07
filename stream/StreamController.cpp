#include "StreamController.h"
#include <spdlog/spdlog.h>

namespace Stream {

CStreamController::CStreamController()
{
    SPDLOG_INFO("CStreamController::CStreamController");
}

CStreamController::~CStreamController()
{
    SPDLOG_INFO("CStreamController::~CStreamController");
}

void CStreamController::start()
{
    ;
}

void CStreamController::stop()
{
    ;
}

} //Stream