from PIL import Image
import numpy as np


im_frame = Image.open('src/gfx/colormap.png')
np_frame = np.array(im_frame.getdata())

out = """unsigned char global_palette[512] =
{"""

outConvimg = """
    fixed-entries:
      """
for i in range(0, 256):
    #8 bit to 5 bit
    # plus 2 for 0b
    r = (f"{(np_frame[i][0]>>3):#0{5+2}b}")[2:]  # 256 -> 32 
    #8 bit to 6 bit
    g = (f"{(np_frame[i][1]>>2):#0{6+2}b}")[2:]  # 256 -> 64
    b = (f"{(np_frame[i][2]>>3):#0{5+2}b}")[2:]  # 256 -> 32

    rgb = str(g[5]) + str(r) + str(g[:5]) + str(b)

    a = int("0b"+rgb[:8],2)
    b = int("0b"+rgb[8:],2)
    #flip a and b for some reason
    out += "\n    "+((f"{b:#0{4}x}"+", ") + (f"{a:#0{4}x}"+",")) + f" /*   {i}: rgb(  {np_frame[i][0]},   {np_frame[i][1]},   {np_frame[i][2]}) */"
    outConvimg += "\n      - color: {index: "+f"{i}"+", r: "+f"{np_frame[i][0]}, g: {np_frame[i][1]}, b: {np_frame[i][2]}"+"}"

out += """
};"""


palette_file = open("src/gfx/global_palette.c", "w")
palette_file.write(out)
print(out)

print("-----------------------")
print(outConvimg)