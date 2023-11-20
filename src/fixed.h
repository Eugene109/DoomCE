#ifndef FIXED_H
#define FIXED_H

#include <graphx.h>

#define SHIFT 8
#define SHIFT_MASK ((1 << SKIFT) - 1)

typedef int fixed;

extern const fixed cosTable[256];

// theta is out of 256, 0 = 0°,  256 = 360°
inline fixed f_cos(uint8_t Θ) { return cosTable[Θ]; }

inline fixed f_sin(uint8_t Θ) { return cosTable[uint8_t(Θ - 64)]; }
inline fixed f_tan(uint8_t Θ) { return (f_sin(Θ) << SHIFT) / f_cos(Θ); }

#endif