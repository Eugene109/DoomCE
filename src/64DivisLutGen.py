
# padding = 8
# string = ""
# for a in range(1,1019):    #  180*(256/(sqrt(32)))
#     string += (f"{(64*256//a):#0{padding}x}")[2:]

# out = ""
# string = string.upper()
# for a in range(0,len(string)//6):
#     if(a%10 == 0):
#         out += "\n    dl  "
#     out += "$" +string[6*a:6*a+6]
#     if(a%10 != 9):
#         out += ", "

# print(out);



padding = 8
string = ""
for a in range(1,1019):    #  180*(256/(sqrt(32)))
    string += (f"{(64*256*256//a):#0{padding}x}")[2:]

out = ""
string = string.upper()
for a in range(0,len(string)//6):
    if(a%10 == 0):
        out += "\n    dl  "
    out += "$" +string[6*a:6*a+6]
    if(a%10 != 9):
        out += ", "

print(out);