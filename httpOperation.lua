-- Serving static files
dofile('httpServer.lua')
httpServer:listen(80)
dofile("LightOpr.lua")



-- Operation of the Light
httpServer:use('/buttonLight', function(req, res)
         gpio.write(buttonLigh, gpio.LOW)
         gpio.write(chipLight, gpio.HIGH)
         res:redirect('index.html?callback=button')
end)

httpServer:use('/chipLight', function(req, res)     
         gpio.write(buttonLigh, gpio.HIGH)
         gpio.write(chipLight, gpio.LOW)
         res:redirect('index.html?callback=chip')
end)

-- Close All Light
httpServer:use('/closeall', function(req, res)
    gpio.write(chipLight, gpio.HIGH)
    gpio.write(buttonLigh, gpio.HIGH)
    res:redirect('index.html?callback=closeall')
end)


