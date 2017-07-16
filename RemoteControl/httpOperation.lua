-- Serving static files
dofile('httpServer.lua')
httpServer:listen(80)
dofile("LightOpr.lua")

-- Operation of the Light
httpServer:use('/', function(req, res)
    
    if(wifi.sta.getip() ~= nil) then
        print('first open index page')
        res:redirect('index.html?callback=wifi&ip='..wifi.sta.getip())
        dofile('remoteOperation.lua')
    else
       res:redirect('index.html')
    end 
end)


-- Operation of the Light
httpServer:use('/buttonLight', function(req, res)
         gpio.write(buttonLigh, gpio.LOW)
         gpio.write(chipLight, gpio.HIGH)
         res:redirect('index.html?callback=button&ip='..wifi.sta.getip())
end)

httpServer:use('/chipLight', function(req, res)     
         gpio.write(buttonLigh, gpio.HIGH)
         gpio.write(chipLight, gpio.LOW)
         res:redirect('index.html?callback=chip&ip='..wifi.sta.getip())
end)

-- Close All Light
httpServer:use('/closeall', function(req, res)
    gpio.write(chipLight, gpio.HIGH)
    gpio.write(buttonLigh, gpio.HIGH)
    res:redirect('index.html?callback=closeall&ip='..wifi.sta.getip())
end)

httpServer:use('/conwifi', function(req, res)
    if(req.query.ssid ~= nil and req.query.pwd ~= nil) then
        station_cfg={}
        station_cfg.ssid=req.query.ssid
        station_cfg.pwd=req.query.pwd
        station_cfg.save=true
        wifi.sta.config(station_cfg)
        wifi.sta.connect()
        count=0
        tmr.alarm(1, 1000, tmr.ALARM_AUTO, function()
                if wifi.sta.getip() == nil then
                    print('Waiting for IP ...')
                    count = count+1
                    if(count==15) then
                        tmr.stop(1)
                        res:redirect('index.html')
                    end
                else
                    print('IP is ' .. wifi.sta.getip())    
                    tmr.stop(1)   
                    res:redirect('index.html?callback=wifi&ip='..wifi.sta.getip())
                    dofile('remoteOperation.lua')    
                end
        end)
     end 
end)


