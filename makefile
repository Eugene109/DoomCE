# ----------------------------
# Makefile Options
# ----------------------------

NAME = DOOM
ICON = icon.png
DESCRIPTION = "CE C Toolchain Demo"
COMPRESSED = NO
ARCHIVED = YES

# OPTIMIZE_FLAG = -ggdb3 -O3

CFLAGS = -Wall -Wextra -Oz# -ffast-math
CXXFLAGS = -Wall -Wextra -Oz# -ffast-math

# ----------------------------

include $(shell cedev-config --makefile)
