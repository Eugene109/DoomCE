from PIL import Image
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
    palette[index] = (r,g,b)
    index += 1

# print(palette)

size = 2;
for i in (1,2,4,8,16,32,64):
    size += i*i

string = """
const unsigned char brick_wall_arr_data["""+str(size)+"""] =
{
    """

padding = 4

for i in (1,2,4,8,16,32,64):
    im_frame = Image.open('src/gfx/brick_wall/brick_wall-'+str(i)+'_x_'+str(i)+'.png')
    np_frame = np.array(im_frame.getdata())
    # palette_indices = []
    for j in range(0, i*i):
        # np_frame[j] is pixel in form [r,g,b,a]
        # must now search through the palette for best matching palette entry
        r = np_frame[j][0]
        g = np_frame[j][1]
        b = np_frame[j][2]
        offset = 1000000
        current_palette_index = 0
        for c in range(0, len(palette)):
            new_offset = pow(palette[c][0] - r, 2)+pow(palette[c][1] - g, 2)+pow(palette[c][2]-b, 2)
            if(new_offset < offset):
                current_palette_index = c
                offset = new_offset
        
        # palette_indices.append(current_palette_index)
        if(j % 16 == 0):
            string += "\n    "
        string += (f"{current_palette_index:#0{padding}x}"+",")
    print(i)

string += """
};
"""

out = open("src/gfx/brick_wall.c", "w")
out.write(string)

print("\n--------------------------------\n")
print(string)


size = 180;
string = """
unsigned char ceiling_floor_tex_data["""+str(size+2)+"""] =
{
    """

padding = 4

im_frame = Image.open('src/gfx/ceiling_floor_tex.png')
np_frame = np.array(im_frame.getdata())
# palette_indices = []
string += (f"{1:#0{padding}x}"+",")
string += (f"{size:#0{padding}x}"+",")
for j in range(0, size):
    # np_frame[j] is pixel in form [r,g,b,a]
    # must now search through the palette for best matching palette entry
    r = np_frame[j][0]
    g = np_frame[j][1]
    b = np_frame[j][2]
    if(j >= size/2):
        r+= 64
        g+= 64
        b+= 64
    
    offset = 1000000
    current_palette_index = 0
    for c in range(0, len(palette)):
        new_offset = pow(palette[c][0] - r, 2)+pow(palette[c][1] - g, 2)+pow(palette[c][2]-b, 2)
        if(new_offset < offset):
            current_palette_index = c
            offset = new_offset
    
    # palette_indices.append(current_palette_index)
    if(j % 16 == 0):
        string += "\n    "
    string += (f"{current_palette_index:#0{padding}x}"+",")

string += """
};
"""

out = open("src/gfx/ceiling_floor_tex.c", "w")
out.write(string)
