chipLight = 4
buttonLigh = 0
gpio.mode(chipLight, gpio.OUTPUT)
gpio.mode(buttonLigh,gpio.OUTPUT)
gpio.write(chipLight, gpio.HIGH)
gpio.write(buttonLigh, gpio.HIGH)

function lightOn(lNo)
    gpio.mode(lNo, gpio.OUTPUT)
    gpio.write(lNo, gpio.LOW)
end

function lightOff(lNo)
    gpio.mode(lNo, gpio.OUTPUT)
    gpio.write(lNo, gpio.HIGH)
end