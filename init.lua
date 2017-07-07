-- init.lua
chipLight = 4
buttonLigh = 0
gpio.mode(chipLight, gpio.OUTPUT)
gpio.mode(buttonLigh,gpio.OUTPUT)
gpio.write(chipLight, gpio.HIGH)
gpio.write(buttonLigh, gpio.HIGH)


print('Setting up WIFI...')

wifi.setmode(wifi.STATION)
--connect to Access Point (DO save config to flash)
station_cfg={}
station_cfg.ssid="cg"
station_cfg.pwd="13501983117"
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()
tmr.alarm(1, 1000, tmr.ALARM_AUTO, function()
    if wifi.sta.getip() == nil then
        print('Waiting for IP ...')
    else
        print('IP is ' .. wifi.sta.getip())    
        tmr.stop(1)        
    end
end)

dofile('httpOperation.lua')

