import math

PI = 3.14159265359

string = """
const fixed cosTable["""+str(int(PI*256)+1)+"""] = {
    """
for a in range(0, int(PI*256)+1):
    string += str(int(math.cos(a/256.0)*256))
    string += ","
    if(a % 10 == 0):
        string += "\n"

print(string)