--## WiFi
WIFI_SSID = "<some>"
WIFI_PASSWORD = "<some>"

HEATING_RELAY_PIN = 1 -- GPIO 5
RELAY_ON = gpio.LOW
RELAY_OFF = gpio.HIGH

--## MQTT
MQTT_CLIENT_ID = "heat_relay"
MQTT_SERVER = "192.168.1.111"
MQTT_PORT = 1883
MQTT_USER = '<some>'
MQTT_PASSWORD = '<some>'
MQTT_TOPIC_INPUT = "/relay/heating/in"
MQTT_TOPIC_OUTPUT = "/relay/heating/out"
MQTT_RECONNECT_INTERVAL = 120



