# *DOOM* on a TI-84 Plus CE
This is a WIP version of the popular game *DOOM* by id Software made for the TI-84 Plus CE written in C++ and eZ80 assembly. This was developed using the community-built [CE toolchain](https://github.com/CE-Programming/toolchain).

The current rendering engine is undergoing massive rewriting, switching from a raycasting grid-based system to an object-based line segment system. The performance-critical components of the rendering engine, such as texture drawing, raycasting(old)/rasterizing(new), and the font drawing algorithms are written in raw assembly. This is because the compiler does not take advantage of the alternate register set, which can be used in assembly if the interrupt routines are disabled.
## Controls
Use the forward and back arrow keys to move, left and right arrow keys to turn, and the apps & prgm buttons to strafe left & right. Alpha fires the pistol and Second performs a secondary action, currently just opening doors.

## How to Run
This code can be run on a TI-84 Plus CE, or on an emulator such as [CEmu](https://ce-programming.github.io/CEmu/). Transfer the .8xv and .8xp files in the bin/ directory to the calculator, as well as the clibs.8xg in the root directory.
