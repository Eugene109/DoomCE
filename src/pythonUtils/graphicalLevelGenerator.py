from tkinter import *
from tkinter import ttk

import time

currentBlockType = 'EmptySelected.TFrame'
def blockTypeChange(event):
    global currentBlockType
    currentBlockType = str(event.widget['style'])[:-7] + 'Selected.TFrame'


def blockClicked(event):
    event.widget['style'] = currentBlockType
def dragFromBlock(event):
    global levelMapArr
    gridStartX = levelMapGrid.winfo_rootx()
    gridStartY = levelMapGrid.winfo_rooty()

    print(str( event.x) + ", " + str( event.y))
    startX = (event.x_root-gridStartX)//20
    endX = startX + (event.x//20)
    startY = (event.y_root - gridStartY)//20
    endY = startY + (event.y//20)
    # for x in range(min(startX, endX), max(startX, endX)+1):
    #     for y in range(min(startY, endY), max(startY, endY)+1):
    levelMapArr[max(min(startX, 15),0)][max(min(startY, 15),0)]['style'] = currentBlockType[:-15] + str('.TFrame')




def blockEntered(event):
    event.widget['style'] = str(event.widget['style'])[:-7] + 'Selected.TFrame'
def blockLeft(event):
    if("Selected" in event.widget['style']):
        event.widget['style'] = str(event.widget['style'])[:-15] + str('.TFrame')

def fillGrid():
    global levelMapArr
    for x in range(0, len(levelMapArr)):
        for y in range(0, len(levelMapArr[x])):
            levelMapArr[x][y]['style'] = currentBlockType[:-15] + '.TFrame'

def sourceClicked(event):
    print(str(event.widget['style']))
    blockTypeChange(event)

def styleToChar(style):
    return style[0].lower()

def charToStyle(char):
    global spaceTypes
    for i in spaceTypes:
        if(char ==  i[0].lower()):
            return i + ".TFrame"

filename = ""
def saveState(*args):
    global levelMapArr
    global filename
    if(filename == ""):
        filename = input("filename: ")
    f = open(filename,"w")
    for y in range(0,16):
        for x in range(0,16):
            f.write(styleToChar(levelMapArr[x][y]['style']) + " ")
        f.write("\n")
    f.close()

def openFile(*args):
    global levelMapArr
    global filename
    if(isinstance(args,str)):
        filename = args
    else:
        filename = input("filename: ")
    f = open(filename,"r")
    for y in range(0,16):
        for x in range(0,16):
            levelMapArr[x][y]['style'] = charToStyle(f.read(2)[0])
        f.read(1)
    f.close()



def xCoord(x, lines_size, quadrant):
    match quadrant:
        case 1:
            return x
        case 2:
            return (lines_size-1)-x
        case 3:
            return (lines_size-1)-x
        case 4:
            return x
def yCoord(y, lines_size, quadrant):
    match quadrant:
        case 1:
            return (lines_size-1)-y
        case 2:
            return (lines_size-1)-y
        case 3:
            return y
        case 4:
            return y

def conv_dark_matter(character, quadrant, transposed):
    if(not character.isdigit()):
        return character
    letters = ""
    match quadrant:
        case 1:
            if(not transposed):
                letters = "ab 0de 0"
            else:
                letters = "de 0ab 0"
        case 2:
            if(not transposed):
                letters = " ba0d0 e"
            else:
                letters = " ed0a0 b"
        case 3:
            if(not transposed):
                letters = " 0ab 0de"
            else:
                letters = " 0de 0ab"
        case 4:
            if(not transposed):
                letters = "a0 b ed0"
            else:
                letters = "d0 e ba0"

    return letters[int(character)-1]

def print_asm_quad(x_lines, y_lines, quadrant):
    asm_out_str = f"_x_walls_q{quadrant}:\n    db  \""
    for y in range (0,len(x_lines)):
        for x in range(0,len(y_lines)):
            asm_out_str += f"{conv_dark_matter(x_lines[yCoord(y,len(x_lines),quadrant)][xCoord(x,len(y_lines),quadrant)], quadrant, False)}"

    asm_out_str += "\"\n"

    asm_out_str += f"_y_walls_q{quadrant}:\n    db  \""
    for y in range (0,len(y_lines)):
        for x in range(0,len(x_lines)):
            asm_out_str += f"{conv_dark_matter(y_lines[yCoord(y,len(y_lines),quadrant)][xCoord(x,len(x_lines),quadrant)], quadrant, False)}"

    asm_out_str += "\"\n"



    asm_out_str += f"_y_walls_transposed_q{quadrant}:\n    db  \""
    for x in range(0,len(x_lines)):
        for y in range (0,len(y_lines)):
            asm_out_str += f"{conv_dark_matter(y_lines[yCoord(y,len(y_lines),quadrant)][xCoord(x,len(x_lines),quadrant)], quadrant, True)}"

    asm_out_str += "\"\n"


    asm_out_str += f"_x_walls_transposed_q{quadrant}:\n    db  \""
    for x in range(0,len(y_lines)):
        for y in range (0,len(x_lines)):
            asm_out_str += f"{conv_dark_matter(x_lines[yCoord(y,len(x_lines),quadrant)][xCoord(x,len(y_lines),quadrant)], quadrant, True)}"

    asm_out_str += "\"\n"



    asm_out_str += "\n"
    asm_out_str += "\n"
    asm_out_str += "\n"

    print(asm_out_str)

def asm_walls_conv(x_lines, y_lines):
    print_asm_quad(x_lines,y_lines, 1)
    print_asm_quad(x_lines,y_lines, 2)
    print_asm_quad(x_lines,y_lines, 3)
    print_asm_quad(x_lines,y_lines, 4)


def newFile():
    print("newFile")

def exportFile(*args):
    global levelMapArr
    x_lines = list()
    y_lines = list()
    x_lines.append(['A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',])
    for y in range(0,15):
        row = list()
        for x in range(0,16):
            if(levelMapArr[x][y]['style'] != levelMapArr[x][y+1]['style']):
                if(levelMapArr[x][y]['style'][:-7] == 'Brick' or levelMapArr[x][y+1]['style'][:-7] == 'Brick'):
                    row.append('A') # x_lines brick is A
                elif(levelMapArr[x][y]['style'][:-7] == 'Portrait' or levelMapArr[x][y+1]['style'][:-7] == 'Portrait'):
                    row.append('C') # x_lines portrait is C
                elif(levelMapArr[x][y]['style'][:-7] == 'Rock' or levelMapArr[x][y+1]['style'][:-7] == 'Rock'):
                    row.append('E') # x_lines portrait is C
                elif(levelMapArr[x][y]['style'][:-7] == 'Door' and levelMapArr[x][y+1]['style'][:-7] == 'Empty' ):
                    row.append('5')
                elif(levelMapArr[x][y]['style'][:-7] == 'Empty' and levelMapArr[x][y+1]['style'][:-7] == 'Door' ):
                    row.append('7')
            else:
                row.append(' ')
        x_lines.append(row)
    x_lines.append(['A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',  'A',])
    print(x_lines)

    for y in range(0,16):
        row = list()
        row.append('B')
        for x in range(0,15):
            if(levelMapArr[x][y]['style'] != levelMapArr[x+1][y]['style']):
                if(levelMapArr[x][y]['style'][:-7] == 'Brick' or levelMapArr[x+1][y]['style'][:-7] == 'Brick'):
                    row.append('B') # y_lines brick is B
                elif(levelMapArr[x][y]['style'][:-7] == 'Portrait' or levelMapArr[x+1][y]['style'][:-7] == 'Portrait'):
                    row.append('D') # y_lines portrait is DB
                elif(levelMapArr[x][y]['style'][:-7] == 'Rock' or levelMapArr[x+1][y]['style'][:-7] == 'Rock'):
                    row.append('F') # y_lines portrait is D
                elif(levelMapArr[x][y]['style'][:-7] == 'Empty' and levelMapArr[x+1][y]['style'][:-7] == 'Door' ):
                    row.append('1')
                elif(levelMapArr[x][y]['style'][:-7] == 'Door' and levelMapArr[x+1][y]['style'][:-7] == 'Empty' ):
                    row.append('3')
            else:
                row.append(' ')
        row.append('B')
        y_lines.append(row)
    print(y_lines)
    asm_walls_conv(x_lines, y_lines)

def closeFile():
    pass

app = Tk()
app.title("Graphical Level Designer")
app.option_add('*tearOff', FALSE)
menubar = Menu(app)
app['menu'] = menubar
menu_file = Menu(menubar)
menu_edit = Menu(menubar)
menubar.add_cascade(menu=menu_file, label='File')
menubar.add_cascade(menu=menu_edit, label='Edit')

menu_file.add_command(label='New', command=newFile)
menu_file.add_command(label='Open...', command=openFile)
recent_files = {"level1.txt", "hi", "lvl_1_gen.py"}
menu_recent = Menu(menu_file)
menu_file.add_cascade(menu=menu_recent, label='Open Recent')
for f in recent_files:
    menu_recent.add_command(label=(f), command=lambda f=f: openFile(f))
menu_file.add_command(label='Save', command=saveState)
menu_file.add_command(label='Export', command=exportFile)
menu_file.add_command(label='Close', command=closeFile)
menu_file.entryconfigure('New', accelerator='Ctrl-N')
menu_file.entryconfigure('Open...', accelerator='Ctrl-O')
menu_file.entryconfigure('Export', accelerator='Ctrl-E')
menu_file.entryconfigure('Save', accelerator='Ctrl-S')

menu_edit.add_command(label='Undo', command=openFile)
menu_edit.add_command(label='Redo', command=openFile)
menu_edit.add_command(label='Fill All', command=fillGrid)
menu_edit.entryconfigure('Undo', accelerator='Ctrl-Z')
menu_edit.entryconfigure('Redo', accelerator='Ctrl-Shift-Z')


app.bind('<Control-KeyPress-o>', openFile)
app.bind('<Control-KeyPress-e>', exportFile)
app.bind('<Control-KeyPress-s>', saveState)


frame = ttk.Frame(app, padding="3 3 12 12")
app.columnconfigure(0, weight=1)
app.rowconfigure(0, weight=1)
frame.grid(column=0, row=0, sticky=(N, W, E, S))

spaceTypes = {'Empty' : 'white', 'Brick' : 'red', 'Portrait' : 'pink', 'Rock' : 'yellow', 'Door' : 'gray'}

myStyle = ttk.Style()
for type in spaceTypes:
    myStyle.configure(type +'.TFrame', background=spaceTypes[type], borderwidth=5, relief='raised')
    myStyle.configure(type +'Selected.TFrame', background=spaceTypes[type], borderwidth=5, relief='sunken')

sideBar = ttk.Frame(frame)
sideBar.grid(column=0,row=0)
currentRow = 0;
for type in spaceTypes:
    label = ttk.Label(sideBar, text=type)
    label.grid(column=0, row=(currentRow))
    source = ttk.Frame(sideBar, width=20, height=20, style=type+'.TFrame')
    source.grid(column=0, row=(currentRow+1))
    source.bind('<ButtonPress-1>', sourceClicked)
    currentRow += 2

# frame['style'] = 'Danger.TFrame'

testing = ttk.Frame(frame)

levelMapGrid = ttk.Frame(frame)
levelMapGrid.grid(column=1,row=0)
levelMapArr = list(list())
for x in range(0,16):
    column = list()
    for y in range(0,16):
        column.append(ttk.Frame(levelMapGrid, width=20, height=20, style='Empty.TFrame'))
        # if(x == 0 & y == 0):
        column[y].grid(column=x, row=y)
        column[y].bind('<ButtonPress-1>', blockClicked)
        column[y].bind('<B1-Motion>', dragFromBlock)
        column[y].bind('<Enter>', blockEntered)
        column[y].bind('<Leave>', blockLeft)
        column[y].setvar('x', x)
        column[y].setvar('y', y)
        column[y].grid_propagate(0)
        text = ttk.Label(column[y],text="a",background="gray")
        text.grid(column=0, row=0, sticky=(N, W, E, S))
        text.grid_configure(padx=5, pady=2)

        ttk.Frame()
    levelMapArr.append(column)


for child in frame.winfo_children(): 
    child.grid_configure(padx=1, pady=1)

app.mainloop()


# from tkinter import *
# from tkinter import ttk

# def calculate(*args):
#     try:
#         value = float(feet.get())
#         meters.set(int(0.3048 * value * 10000.0 + 0.5)/10000.0)
#     except ValueError:
#         pass

# root = Tk()
# root.title("Feet To Meters")

# mainframe  = ttk.Frame(root, padding="3 3 12 12")
# mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
# root.columnconfigure(0, weight=1)
# root.rowconfigure(0, weight=1)

# feet = StringVar()
# feet_entry = ttk.Entry(mainframe, width=7, textvariable=feet)
# feet_entry.grid(column=2, row=1, sticky=(W,E))

# meters = StringVar()
# ttk.Label(mainframe, textvariable=meters).grid(column=2, row=2, sticky=(W, E))

# ttk.Button(mainframe, text="Calculate", command=calculate).grid(column=3, row=3, sticky=W)

# ttk.Label(mainframe, text="feet").grid(column=3, row=1, sticky=W)
# ttk.Label(mainframe, text="is equivalent to").grid(column=1, row=2, sticky=E)
# ttk.Label(mainframe, text="meters").grid(column=3, row=2, sticky=W)

# for child in mainframe.winfo_children(): 
#     child.grid_configure(padx=5, pady=5)

# feet_entry.focus()
# root.bind("<Return>", calculate)

# root.mainloop()