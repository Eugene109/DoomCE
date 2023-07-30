x_lines = list()
y_lines = list()
x_lines_transposed = list()
y_lines_transposed = list()

x_lines.append(   ['b',  'b',  'b',  'b',  'b',  'b',  'b',  'b',])
y_lines.append(['b',  ' ',  ' ',  'b',  ' ',  ' ',  ' ',  ' ',  'b',])
x_lines.append(   [' ',  ' ',  ' ',  ' ',  'b',  'b',  'b',  ' ',])
y_lines.append(['b',  ' ',  ' ',  'b',  'b',  ' ',  'b',  'b',  'b',])
x_lines.append(   [' ',  ' ',  ' ',  ' ',  ' ',  ' ',  ' ',  ' ',])
y_lines.append(['b',  ' ',  ' ',  'b',  'b',  ' ',  'b',  'b',  'b',])
x_lines.append(   [' ',  ' ',  'b',  ' ',  'b',  ' ',  ' ',  ' ',])
y_lines.append(['b',  ' ',  'b',  ' ',  ' ',  'b',  'b',  'b',  'b',])
x_lines.append(   [' ',  ' ',  ' ',  ' ',  ' ',  ' ',  ' ',  ' ',])
y_lines.append(['b',  ' ',  'b',  ' ',  ' ',  'b',  'b',  ' ',  'b',])
x_lines.append(   [' ',  ' ',  ' ',  ' ',  ' ',  ' ',  'b',  'b',])
y_lines.append(['b',  ' ',  'b',  ' ',  ' ',  'b',  ' ',  ' ',  'b',])
x_lines.append(   [' ',  ' ',  ' ',  ' ',  ' ',  ' ',  ' ',  ' ',])
y_lines.append(['b',  ' ',  'b',  ' ',  ' ',  'b',  ' ',  ' ',  'b',])
x_lines.append(   [' ',  ' ',  ' ',  ' ',  ' ',  ' ',  ' ',  ' ',])
y_lines.append(['b',  ' ',  'b',  ' ',  ' ',  'b',  ' ',  ' ',  'b',])
x_lines.append(   ['b',  'b',  'b',  'b',  'b',  'b',  'b',  'b',])

for y in range(0,9):
    temp_list = list()
    for x in range(0,8):
        temp_list.append(y_lines[x][y])
    y_lines_transposed.append(temp_list)

for y in range(0,8):
    temp_list = list()
    for x in range(0,9):
        temp_list.append(x_lines[x][y])
    x_lines_transposed.append(temp_list)

out_str = """
extern unsigned char lvl_1_x_walls[72] = {
"""
for y in range (0,9):
    for x in range(0,8):
        out_str += f"'{x_lines[8-y][x]}',  "
    out_str += "\n\n"
out_str+="""
};

extern unsigned char lvl_1_y_walls[72] = {
"""
for y in range (0,8):
    for x in range(0,9):
        out_str += f"'{y_lines[7-y][x]}',  "
    out_str += "\n\n"
out_str+="""
};

extern unsigned char lvl_1_x_walls_transposed[72] = {
"""
for x in range (0,8):
    for y in range(0,9):
        out_str += f"'{x_lines_transposed[x][y]}',  "
    out_str += "\n\n"
out_str+="""
};

extern unsigned char lvl_1_y_walls_transposed[72] = {
"""
for x in range (0,9):
    for y in range(0,8):
        out_str += f"'{y_lines_transposed[x][y]}',  "
    out_str += "\n\n"
out_str+="""
};
"""

print(out_str)

asm_out_str = "\""
for y in range (0,9):
    for x in range(0,8):
        asm_out_str += f"{x_lines[8-y][x]}"

asm_out_str += "\""

asm_out_str += "\n"

asm_out_str += "\""
for y in range (0,8):
    for x in range(0,9):
        asm_out_str += f"{y_lines[7-y][x]}"

asm_out_str += "\""




asm_out_str += "\ntransposed strings:\n\""
for x in range(0,8):
    for y in range (0,9):
        asm_out_str += f"{x_lines[8-y][x]}"

asm_out_str += "\""

asm_out_str += "\n"

asm_out_str += "\""
for x in range(0,9):
    for y in range (0,8):
        asm_out_str += f"{y_lines[7-y][x]}"

asm_out_str += "\""

print(asm_out_str)