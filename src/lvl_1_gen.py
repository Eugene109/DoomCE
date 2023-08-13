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

asm_out_str = "_x_walls:\n    db  \""
for y in range (0,9):
    for x in range(0,8):
        asm_out_str += f"{x_lines[8-y][x]}"

asm_out_str += "\"\n"

asm_out_str += "_y_walls:\n    db  \""
for y in range (0,8):
    for x in range(0,9):
        asm_out_str += f"{y_lines[7-y][x]}"

asm_out_str += "\"\n"



asm_out_str += "_y_walls_transposed:\n    db  \""
for x in range(0,9):
    for y in range (0,8):
        asm_out_str += f"{y_lines[7-y][x]}"

asm_out_str += "\"\n"


asm_out_str += "\n"
asm_out_str += "_x_walls_transposed:\n    db  \""
for x in range(0,8):
    for y in range (0,9):
        asm_out_str += f"{x_lines[8-y][x]}"

asm_out_str += "\"\n"







asm_out_str += "\n"
asm_out_str += "\n"
asm_out_str += "\n"

# quadrant 2


asm_out_str += "_x_walls_q2:\n    db  \""
for y in range (0,9):
    for x in range(0,8):
        asm_out_str += f"{x_lines[8-y][7-x]}"

asm_out_str += "\"\n"

asm_out_str += "_y_walls_q2:\n    db  \""
for y in range (0,8):
    for x in range(0,9):
        asm_out_str += f"{y_lines[7-y][8-x]}"

asm_out_str += "\"\n"




asm_out_str += "_y_walls_transposed_q2:\n    db  \""
for x in range(0,9):
    for y in range (0,8):
        asm_out_str += f"{y_lines[7-y][8-x]}"

asm_out_str += "\"\n"

asm_out_str += "\n"
asm_out_str += "_x_walls_transposed_q2:\n    db  \""
for x in range(0,8):
    for y in range (0,9):
        asm_out_str += f"{x_lines[8-y][7-x]}"

asm_out_str += "\"\n"







asm_out_str += "\n"
asm_out_str += "\n"
asm_out_str += "\n"

# quadrant 3


asm_out_str += "_x_walls_q3:\n    db  \""
for y in range (0,9):
    for x in range(0,8):
        asm_out_str += f"{x_lines[y][7-x]}"

asm_out_str += "\"\n"

asm_out_str += "_y_walls_q3:\n    db  \""
for y in range (0,8):
    for x in range(0,9):
        asm_out_str += f"{y_lines[y][8-x]}"

asm_out_str += "\"\n"


asm_out_str += "_y_walls_transposed_q3:\n    db  \""
for x in range(0,9):
    for y in range (0,8):
        asm_out_str += f"{y_lines[y][8-x]}"

asm_out_str += "\"\n"


asm_out_str += "\n"
asm_out_str += "_x_walls_transposed_q3:\n    db  \""
for x in range(0,8):
    for y in range (0,9):
        asm_out_str += f"{x_lines[y][7-x]}"

asm_out_str += "\"\n"







asm_out_str += "\n"
asm_out_str += "\n"
asm_out_str += "\n"

# quadrant 4


asm_out_str += "_y_walls_q4:\n    db  \""
for y in range (0,8):
    for x in range(0,9):
        asm_out_str += f"{y_lines[y][x]}"

asm_out_str += "\"\n"


asm_out_str += "_x_walls_q4:\n    db  \""
for y in range (0,9):
    for x in range(0,8):
        asm_out_str += f"{x_lines[y][x]}"

asm_out_str += "\"\n"



asm_out_str += "_y_walls_transposed_q4:\n    db  \""
for x in range(0,9):
    for y in range (0,8):
        asm_out_str += f"{y_lines[y][x]}"

asm_out_str += "\"\n"

asm_out_str += "\n"
asm_out_str += "_x_walls_transposed_q4:\n    db  \""
for x in range(0,8):
    for y in range (0,9):
        asm_out_str += f"{x_lines[y][x]}"

asm_out_str += "\"\n"



print(asm_out_str)