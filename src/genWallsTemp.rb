for i in 1..80 do
    puts """
    dl $001"""+rand(256*16).to_s(16).rjust(3, '0').upcase+"""    ; x1
    dl $002"""+rand(256*16).to_s(16).rjust(3, '0').upcase+"""    ; y1 
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db \"A\"        ; wallType
"""
end