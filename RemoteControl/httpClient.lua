dofile('LightOpr.lua')

disconn = 0
i=0
function createConnection(url,port,requestUrl,Host,apiKey,device,sensor)    
    -- Create a Connection
    conn=net.createConnection(net.TCP, 0) 
    
    -- Open the Connection
    conn:connect(port,url)
    
    -- When connected then change the status
    conn:on("connection",function(conn,pl) disconn=1 sendRequest(requestUrl,Host,apiKey,device,sensor) end)
    
    -- Get the response from the server from request before
    conn:on("receive", function(conn, pl) 
        local data = string.match(pl,"%b{}")    
        local x = sjson.decode(data)
        local sid = x["sensor_id"]
        local gpioNo = getGPIONo(sid)
        
        if x["value"] == 0 then
            print("The current status of "..x["sensor_id"].." is Closed")            
            if gpioNo ~= nil then
               lightOff(gpioNo)
            end
        else
            print("The current status of "..x["sensor_id"].." is Opened") 
            if gpioNo ~= nil then
               lightOn(gpioNo)
            end
        end     
    end)

    -- When disconnected then change the status,and colse the connection
    conn:on("disconnection",function(conn,pl)  disconn=0 print(conn)  end)

end

function sendRequest(url,Host,apiKey,device,sensor)        
    url = string.gsub(url,"%b{}",device,1)
    url = string.gsub(url,"%b{}",sensor,1)

    conn:send("GET "
    ..url
    .." HTTP/1.1\r\n"
    .."Host:"
    ..Host
    .."\r\n"
    .."U-ApiKey:"..apiKey
    .."\r\n"
    .."Cache-Control: no-cache\r\n\r\n")

--    conn:send("GET /v1.0/device/359733/sensor/410015/datapoints HTTP/1.1\r\n"
--            .."Host: api.yeelink.net\r\n"
--            .."U-ApiKey: 757d41dcd56a0de83c2a34b29752c4fe\r\n"
--            .."Cache-Control: no-cache\r\n\r\n")
    i=i+1
end

function getGPIONo(sensorID)
    if file.open("config.ini") then
    content = file.read()
    file.close()
    end

    res = nil

    data = string.match(content,"%b{}") 
    t = sjson.decode(data)
    DeviceNum = t["DeviceNum"]
    for i=1,DeviceNum,1 do
        if t["Devices"][i]["SensorID"] == sensorID then
            res = t["Devices"][i]["gpioNo"]
            break
        end
    end

    return res
end