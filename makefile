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

# ----------------------------

include $(shell cedev-config --makefile)
