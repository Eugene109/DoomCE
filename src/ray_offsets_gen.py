
for x in range(0,80):
    rayX=x/80*256*2-256
    rayY=256
    length = pow(rayX*rayX+rayY*rayY,0.5)
    rayX/=length
    rayY/=length
    rayX*=256
    rayY*=256
    rayX = int(rayX)
    rayY = int(rayY)
    print(f"ivec2({rayX}, {rayY}),")