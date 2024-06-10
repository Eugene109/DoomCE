import math

PI = 3.14159265359

string = """
const fixed cosTable["""+str(int(256))+"""] = {
    """
for a in range(0, int(256)):
    string += str(int(math.cos(a/256.*2*PI)*256))
    string += ","
    if(a % 10 == 0):
        string += "\n"

#    x1: |= 0011
#    fy: |= 0101
#    y1: |= 1100
#    fx: |= 1010

# cosine is fx
# sine is fy

# q1: cos+,sin+   0000
# q2: cos-,sin+   1010
# q4: cos-,sin-   1111
# q2: cos+,sin-   0101



print(string)