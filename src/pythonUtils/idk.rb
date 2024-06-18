file = File.open("div_table.8xv", "rb")

contents = file.read
puts contents.unpack("C"*1000).sum.to_s(16)