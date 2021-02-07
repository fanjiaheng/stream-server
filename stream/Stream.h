#pragma once

namespace Stream {

class IStream
{
public:
    IStream() {};
    virtual ~IStream() {};

public:
    virtual void start() = 0;
    virtual void stop() = 0;
};

} //Stream