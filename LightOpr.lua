chipLight = 4
buttonLigh = 0
gpio.mode(chipLight, gpio.OUTPUT)
gpio.mode(buttonLigh,gpio.OUTPUT)
gpio.write(chipLight, gpio.HIGH)
gpio.write(buttonLigh, gpio.HIGH)