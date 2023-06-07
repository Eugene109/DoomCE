from PIL import Image
import numpy as np

lvl_name = input("Name of level(no space, no -, cannot start with number) :")
lvl_map_path = input("Path to level image :")

im_frame = Image.open(lvl_map_path)
np_frame = np.array(im_frame.getdata())

height = im_frame.height
width = im_frame.width

img = list()
for y in range(0, height):
    row = list()
    for x in range(0,width):
        row.append(np_frame[y*width+x])
    img.append(row)

class X_line:
    def __init__(self, pos, minimum, maximum) -> None:
        self.pos = pos
        self.yMin = minimum
        self.yMax = maximum
    def ToCppDefString(self):
        return f"AA_Line(X_LINE, {self.pos}, {self.yMin}, {self.yMax}, 0, {self.yMax-self.yMin})"
class Y_line:
    def __init__(self, pos, minimum, maximum) -> None:
        self.pos = pos
        self.xMin = minimum
        self.xMax = maximum
    def ToCppDefString(self):
        return f"AA_Line(Y_LINE, {self.pos}, {self.xMin}, {self.xMax}, 0, {self.xMax-self.xMin})"

x_lines = list()
y_lines = list()


# X-lines
for y in range(0, height):
    start = -1
    for x in range(0,width):
        if(np.array_equiv(img[y][x],([255,255,255,255]))):
            # if no line was started, keep going
            # end line, if already started
            # if line was started previous pixel(one pixel line), skip
            if(start == -1):
                continue
            elif(start == x-1):
                start = -1
            else:
                x_lines.append(X_line(-1*(y-(height//2)), (start-(width//2)), x))
                start = -1
        else:
            # will add support for multiple textures (colors) later
            # if line was started, continue line
            # else, start line here
            if(start != -1):
                continue
            elif(start == -1):
                start = x


# now for Y-lines
for x in range(0, width):
    start = -1
    for y in range(0,height):
        if(np.array_equiv(img[y][x],([255,255,255,255]))):
            # if no line was started, keep going
            # end line, if already started
            # if line was started previous pixel(one pixel line), skip
            if(start == -1):
                continue
            elif(start == y-1):
                start = -1
            else:
                y_lines.append(Y_line((x-(height//2)), (-1*(y-(height//2))), (-1*(start-(height//2)))))
                start = -1
        else:
            # will add support for multiple textures (colors) later
            # if line was started, continue line
            # else, start line here
            if(start != -1):
                continue
            elif(start == -1):
                start = y

# print(img)

lvl_name_upper = lvl_name.upper()

out_str = f"""#ifndef {lvl_name_upper}_LVL
#define {lvl_name_upper}_LVL"""+"""

#include "aa_lines.h"

#ifndef __cplusplus
assert(0);
#endif
"""+f"""
const uint8_t {lvl_name_upper}_NUM_LINES = {len(x_lines)+len(y_lines)};
AA_Line {lvl_name}_lines[{lvl_name_upper}_NUM_LINES] = """+"{\n"

for line in x_lines:
    out_str += f"""
        {line.ToCppDefString()},"""

for line in y_lines:
    out_str += f"""
        {line.ToCppDefString()},"""

out_str += """
};

#endif
"""

print(out_str)