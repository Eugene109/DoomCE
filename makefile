# ----------------------------
# Makefile Options
# ----------------------------

NAME = DOOM
ICON = icon.png
DESCRIPTION = "CE C Toolchain Demo"
COMPRESSED = NO
ARCHIVED = NO

# OPTIMIZE_FLAG = -ggdb3 -O3

CFLAGS = -Wall -Wextra -Oz# -ffast-math -v
CXXFLAGS = -Wall -Wextra -Oz# -ffast-math -v

MAKE_GFX = cd $(GFXDIR) && $(CONVIMG) && convbin -i divTable.bin -o divTable.8xv -k 8xv -n divTable && echo HIII

# ----------------------------
include $(shell cedev-config --makefile)

