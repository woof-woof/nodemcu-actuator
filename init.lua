dofile("config.lua")
dofile("wifi_init.lua")

--## Heating ##--
dofile("bufferedGpio.lua")
bufferedGpio.debug = false
bufferedGpio.init(HEATING_RELAY_PIN, 5, gpio.HIGH)

-- init wifi then resume
wifi_init(function ()
    if file.open("init.lua") == nil then
        print("init.lua deleted or renamed")
    else
        print("Running")
        file.close("init.lua")
        dofile("app.lua")
    end
end)
