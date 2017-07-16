dofile('httpClient.lua')
-- Input Parmas
--connectionUrl = "www.yeelink.net"
--connectionPort = 80
--requestUrl = "/v1.0/device/{deviceNo}/sensor/{sensorNo}/datapoints"
--Host = "api.yeelink.net"
--apiKey = "757d41dcd56a0de83c2a34b29752c4fe"
--buttonDeviceID = "359733"
--buttonSensorID = "410015"
if file.open("config.ini") then
    content = file.read()
    file.close()
end
data = string.match(content,"%b{}") 
t = sjson.decode(data)
apiKey = t["U-ApiKey"]
connectionUrl = t["Url"]
connectionPort = t["Port"]
requestUrl = t["requestUrl"]
Host = t["Host"]
--DeviceNum = t["DeviceNum"]
--for i=1,DeviceNum,1 do
--    if t["Devices"][i]["DeviceName"] == 'button' then
--        buttonDeviceID = t["Devices"][i]["DeviceID"]
--        buttonSensorID = t["Devices"][i]["SensorID"]
--        break
--    end
--end
buttonDeviceID = t["Devices"][1]["DeviceID"]
buttonSensorID = t["Devices"][1]["SensorID"]
chipDeviceID = t["Devices"][2]["DeviceID"]
chipSensorID = t["Devices"][2]["SensorID"]


 -- Go into trigger
tmr.alarm(1,2000,1,function()
    if disconn ==0 then
        createConnection(connectionUrl,connectionPort,requestUrl,Host,apiKey,buttonDeviceID,buttonSensorID)
        createConnection(connectionUrl,connectionPort,requestUrl,Host,apiKey,chipDeviceID,chipSensorID)     
    else
        sendRequest(requestUrl,Host,apiKey,buttonDeviceID,buttonSensorID)
        sendRequest(requestUrl,Host,apiKey,chipDeviceID,chipSensorID)
    end
end)
