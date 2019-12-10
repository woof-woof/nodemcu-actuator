--## BUFFERED GPIO
--  ensures that changes to a GPIO state have a minimum period of time between
--  if a change is requested earlier than appropiate, it will be delayed until after the minimum period has passed

local P = {}
bufferedGpio = P
P.stateUpdateCheckInterval = 1000 --miliSeconds
P.minDelta = {}
P.currentState = {}
P.lastChangeTime = {}
P.desiredState = {}
P.debug = false


function P.init(pin, bufferMinDelta, initialState)
    P.logd("Initing bufferedGpio pin " .. pin)
    gpio.mode(pin, gpio.OUTPUT)
    gpio.write(pin, initialState)
    P.currentState[pin] = initialState
    P.desiredState[pin] = initialState
    P.lastChangeTime[pin] = -bufferMinDelta - 1
    P.minDelta[pin] = bufferMinDelta
    if not P.timer then
        P._run()
    end
end

-- Gpio write, but if last change was done less than minDelta seconds ago
-- delay change
function P.write(pin, value)
    P.desiredState[pin] = value
end

--running task that changes gpio state when appropiate
--ensures that time between changes is >= minDelta
function P._run()
    P.timer = tmr.create():alarm(P.stateUpdateCheckInterval, tmr.ALARM_AUTO, function()
        P.logd("bufferedGpio task running")
        cTime = tmr.time()
        for pin in pairs(P.currentState) do
            if (P.desiredState[pin] ~= P.currentState[pin]) then
                if (P.abs(P.lastChangeTime[pin] - cTime) >= P.minDelta[pin]) then
                    if P.debug then
                        print("bufferedGpio set pin " .. pin .. " to " .. P.desiredState[pin])
                    end
                    P.lastChangeTime[pin] = cTime
                    gpio.write(pin, P.desiredState[pin])
                    P.currentState[pin] = P.desiredState[pin]
                end
            end
        end
    end)
end

--## UTILS
function P.abs(nr)
    if (nr < 0) then return -nr end
    return nr
end

-- Log debug
function P.logd(str)
    if P.debug then
        print(str)
    end
end

return bufferedGpio
