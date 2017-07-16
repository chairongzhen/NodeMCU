-- init.lua
do
def_sta_config = wifi.sta.getconfig(true)
--print(string.format("\tDefault station config\n\tssid:\"%s\"\tpassword:\"%s\"%s", def_sta_config.ssid, def_sta_config.pwd, (type(def_sta_config.bssid)=="string" and "\tbssid:\""..def_sta_config.bssid.."\"" or "")))
end

if def_sta_config.ssid == "cg" then
    wifi.setmode(wifi.STATION)
    wifi.sta.connect()

    tmr.alarm(1, 1000, tmr.ALARM_AUTO, function()
        if wifi.sta.getip() == nil then
            print('Waiting for IP ...')
        else
            print('IP is ' .. wifi.sta.getip())    

            tmr.stop(1)
            if file.exists("config.ini") then
                dofile('remoteOperation.lua') 
            else
                print('please go to the settting page first')
            end        
        end
    end)
else
    print('Setting up WIFI...')
    wifi.setmode(wifi.STATIONAP)
    wifi.ap.config({ ssid = 'mymcu', auth = AUTH_OPEN })
    wifi.sta.connect()    
end
    




--print('Setting up WIFI...')


dofile('httpOperation.lua')
--dofile('LightOpr.lua')









