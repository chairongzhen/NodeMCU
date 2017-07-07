-- Serving static files
dofile('httpServer.lua')
httpServer:listen(80)
dofile("LightOpr.lua")
-- Custom API
-- Light the Chip Light
httpServer:use('/buttonLight', function(req, res)
         gpio.write(buttonLigh, gpio.LOW)
         gpio.write(chipLight, gpio.HIGH)
end)

httpServer:use('/chipLight', function(req, res)     
         gpio.write(buttonLigh, gpio.HIGH)
         gpio.write(chipLight, gpio.LOW)
end)


-- Light the Button Light
httpServer:use('/buttonlighton', function(req, res)
        gpio.write(buttonLigh, gpio.HIGH)
        gpio.write(chipLight, gpio.LOW)
end)

-- Get json
httpServer:use('/json', function(req, res)
    res:type('application/json')
    res:send('{"doge": "smile"}')
end)

-- Close All Light
httpServer:use('/closeall', function(req, res)
    gpio.write(chipLight, gpio.HIGH)
    gpio.write(buttonLigh, gpio.HIGH)
end)
