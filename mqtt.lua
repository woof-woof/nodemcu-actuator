-- on connection error
function onConnectionError(client)
  print("Disconnected. Attempting reconnection...")
  tmr.create():alarm(MQTT_RECONNECT_INTERVAL, tmr.ALARM_SINGLE, mqttReconnect)
end

-- on connection success
function onConnectionSuccess(client)
  print("Connection established successfuly")
  client:subscribe(MQTT_TOPIC_INPUT, 0, onSubscribeSuccess)
end
function onSubscribeSuccess(client)
  print("Subscribed successfully to "..MQTT_TOPIC_INPUT)
end

-- reconnect
function mqttReconnect()
  MQTT_CLIENT:connect(MQTT_SERVER, onConnectionSuccess)
end

-- initial connect
function mqttConnect()
  MQTT_CLIENT:connect(MQTT_SERVER, onConnectionSuccess, onConnectionError)
end

function init_mqtt(client)
    MQTT_CLIENT = client
    mqttConnect()
end

return init_mqtt