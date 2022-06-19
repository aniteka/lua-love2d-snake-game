local _FrameLimit_t_ = 0;
---@param limit number
---@param dt number
---@param callback function
local function FrameLimitFunction(limit, dt, callback)
    assert(type(limit) == "number")
    assert(type(dt) == "number")
    assert(type(callback) == "function")
    _FrameLimit_t_ = _FrameLimit_t_ + dt
    while _FrameLimit_t_ >= 1/limit do
        _FrameLimit_t_ = _FrameLimit_t_ - 1/limit
        callback()
    end
end

return FrameLimitFunction;