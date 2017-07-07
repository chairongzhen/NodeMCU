-- Operation of the two lights on the board.
--gpio.mode(0,gpio.OUTPUT)
--gpio.write(0,gpio.LOW)
--gpio.mode(4,gpio.OUTPUT)
--gpio.write(4,gpio.LOW)
print('Blink Demo')
lighton=0
led=0
chip=4
gpio.write(led, gpio.HIGH)
tmr.alarm(0,1000,1,function()
if lighton==0 then
    lighton=1
    gpio.mode(led, gpio.OUTPUT)
    gpio.mode(chip,gpio.OUTPUT)
    gpio.write(led, gpio.LOW)
    gpio.write(chip,gpio.HIGH)
else
    lighton=0
    gpio.write(led, gpio.HIGH)
    gpio.write(chip,gpio.LOW)
end
end)
gpio.mode(led, gpio.INPUT)
gpio.mode(chip, gpio.INPUT)