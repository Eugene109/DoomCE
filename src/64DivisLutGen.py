
padding = 8
string = ""
for a in range(1,641):
    string += (f"{(64*256//a):#0{padding}x}")[2:]

out = ""
string = string.upper()
for a in range(0,len(string)//6):
    if(a%10 == 0):
        out += "\ndl  "
    out += "$" +string[6*a:6*a+6] + ", "

print(out);