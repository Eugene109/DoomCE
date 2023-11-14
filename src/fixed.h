#ifndef FIXED_H
#define FIXED_H

#include <graphx.h>

#define SHIFT 8
#define SHIFT_MASK ((1 << SKIFT) - 1)

typedef int fixed;

extern const fixed cosTable[256];

// theta is out of 256, 0 = 0deg,  256 = 360deg
inline fixed f_cos(uint8_t theta) { return cosTable[theta]; }

inline fixed f_sin(uint8_t theta) { return cosTable[uint8_t(theta - 64)]; }
inline fixed f_tan(uint8_t theta) { return (f_sin(theta) << SHIFT) / f_cos(theta); }

#endif