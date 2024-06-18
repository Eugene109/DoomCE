# ----------------------------
# Makefile Options
# ----------------------------

NAME = DOOM
ICON = icon.png
DESCRIPTION = "CE C Toolchain Demo"
COMPRESSED = NO
ARCHIVED = YES

# OPTIMIZE_FLAG = -ggdb3 -O3

CFLAGS = -Wall -Wextra -Oz# -ffast-math -v
CXXFLAGS = -Wall -Wextra -Oz# -ffast-math -v

MAKE_GFX = cd $(GFXDIR) && $(CONVIMG) && convbin -i div_table.bin -o div_table.8xv -k 8xv -n div_tabl

# ----------------------------

include $(shell cedev-config --makefile)
