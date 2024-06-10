
PI = 3.14159265359

string = "\npublic _cos_table_255_256\n_cos_table_255_256:\n    db "
for a in 0..255 do
    hex = ((Math.cos(a/256.0*2*PI)*255).to_i.abs).to_s(16).upcase
    hex = "0"+hex if hex.length==1
    string += "$"+hex+","
    string += "\n    db " if a%30 == 29
end

puts string

string = "\npublic _sin_table_255_256\n_sin_table_255_256:\n    db "
for a in 0..255 do
    hex = ((Math.sin(a/256.0*2*PI)*255).to_i.abs).to_s(16).upcase
    hex = "0"+hex if hex.length==1
    string += "$"+hex+","
    string += "\n    db " if a%30 == 29
end

puts string

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


string = "\npublic _sign_table_fx_fy\n_sign_table_fx_fy:\n    db "
for a in 0..255 do
    if a%64 == 0 or a < 64 then
        string += "0000b,"
    elsif a < 128
        string += "1010b,"
    elsif a < 192
        string += "1111b,"
    else
        string += "0101b,"
    end
    string += "\n    db " if a%20 == 19
end

puts string