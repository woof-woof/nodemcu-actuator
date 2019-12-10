dofile('mqtt.lua')
MQTT_CLIENT = mqtt.Client(MQTT_CLIENT_ID, 120, MQTT_USER, MQTT_PASSWORD)
init_mqtt(MQTT_CLIENT)

MQTT_CLIENT:on("message", function (client, topic, data)
  print("Received message: "..data)
  if data == "status" then
    if HEATING_RELAY_STATE == RELAY_ON then 
        status = 1 
    else 
        status = 0
    end
    client:publish(MQTT_TOPIC_OUTPUT, status, 0, 0)
  end
  if data == "on" then
    bufferedGpio.write(HEATING_RELAY_PIN, RELAY_ON)
    HEATING_RELAY_STATE = RELAY_ON
    client:publish(MQTT_TOPIC_OUTPUT, 1, 0, 0)
  end
  if data == "off" then
    bufferedGpio.write(HEATING_RELAY_PIN, RELAY_OFF)
    HEATING_RELAY_STATE = RELAY_OFF
    client:publish(MQTT_TOPIC_OUTPUT, 0, 0, 0)
  end
end)
