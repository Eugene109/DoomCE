wallTypes = ["A", "B", "C","D","E"]

for i in 1..80 do
    puts """
    dl $001"""+rand(256*16).to_s(16).rjust(3, '0').upcase+"""    ; x1
    dl $002"""+rand(256*16).to_s(16).rjust(3, '0').upcase+"""    ; y1 
    dl $00"""+rand(256*8).to_s(16).rjust(4, '0').upcase+"""    ; dx
    dl $00"""+rand(256*8).to_s(16).rjust(4, '0').upcase+"""    ; dy
    db """+rand(2).to_s(2)*2 + rand(2).to_s(2)*2+"""b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db \""""+wallTypes[rand(wallTypes.length)]+"""\"        ; wallType
"""
end