import turtle
import time

import numpy as np

palette_file = open("src/gfx/global_palette.c", "r")
palette_lines = palette_file.read().split('\n')
palette = dict()
index = 0

for i in range(2, len(palette_lines)- 2):
    current_line = palette_lines[i]

    r = int(current_line.split("rgb(")[1].split(", ")[0])
    g = int(current_line.split("rgb(")[1].split(", ")[1])
    b = int(current_line.split("rgb(")[1].split(", ")[2].split(")")[0])
    palette[index] = (r/255.0,g/255.0,b/255.0)
    index += 1

turtle.up()
turtle.speed(0)
turtle.setx(-100)
for i in range(0,8):
    for j in range(0,32):
        turtle.dot(10,palette[j+i*32])
        turtle.forward(10)
    turtle.sety(turtle.pos()[1] - 10)
    turtle.setx(-100)


time.sleep(10)