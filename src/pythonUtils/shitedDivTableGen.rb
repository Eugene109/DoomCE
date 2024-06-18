my_binary_data = [0]

string = """
public _div_table_255_256
_div_table_255_256:
    db $00"""
numBytes = 1;
for b in 1..255 do
    string += "\n    db ";
    for a in 0..255 do
        hex = (((a*1.0)/(b*1.0))*255).to_i.to_s(16).upcase
        hex = "0"+hex if hex.length==1
        next if a>b
        my_binary_data.append((((a*1.0)/(b*1.0))*255).to_i)
        string += "$"+hex+","
        numBytes += 1
        string = string[0..string.length-2] + "\n    db " if a%16 == 15
    end
    if string[string.length-1] == ',' then
        string = string[0..string.length-2];
    end
    if string[string.length-1] == ' ' then
        string = string[0..string.length-9];
    end
end
puts string
puts numBytes

File.binwrite("./src/gfx/div_table.bin", my_binary_data.pack("C"*my_binary_data.length))