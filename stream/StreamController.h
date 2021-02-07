#pragma once
#include "Stream.h"
#include <string>

namespace Stream {

class CStreamController : public IStream
{
public:
    CStreamController();
    ~CStreamController();

    static CStreamController* instance() {
        static CStreamController inst;
        return &inst;
    }

public:
    void start() override;
    void stop() override;

private:
    std::string m_name;
};

} //Stream