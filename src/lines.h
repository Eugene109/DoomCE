#ifndef LINES_H
#define LINES_H
// line segments defined by endpoints
// possible optimizations:
//   - use assembly for raycast hit detection
//   - cache hits?

#include <graphx.h>

#include <cassert>

#include "fixed.h"
#include "matrixMath.h"
#include "vectorMath.h"

#define DELTA 16 // maybe decrease a little?

// +Y is forward,
// +X is right
// X is parallel to x-axis

class Line {
  public:
    Line(vec2 p1, vec2 p2, double t1, double t2) {
        pos1.x = (p1 * (1 << SHIFT)).x;
        pos1.y = (p1 * (1 << SHIFT)).y;
        pos2.x = (p2 * (1 << SHIFT)).x;
        pos2.y = (p2 * (1 << SHIFT)).y;
        tex1 = t1 * (1 << SHIFT);
        tex2 = t2 * (1 << SHIFT);
        wPos1 = pos1;
        wPos2 = pos2;
    }
    bool rayIntersection(const ivec2 &ray, ivec2 *hit, fixed *texCoord) {
        // optimizations:
        //  branch after denominator calculation
        //   same sign denom & numerator is positive, opposite is not
        //    this is faster than if(r>0)
        //   numerator < denom means s < 1
        //    this is faster
        ivec2 A = wPos1;
        ivec2 B = wPos2;
        fixed denom = ((ray.x) * (B.y - A.y) - (ray.y) * (B.x - A.x)) >> SHIFT;
        fixed rN = ((A.y) * (A.x - B.x) - (A.x) * (A.y - B.y)) /*  >> SHIFT */;
        fixed sN = ((A.x) * (ray.y) - (A.y) * (ray.x)) /*  >> SHIFT */;

        fixed r = rN / denom;
        fixed s = sN / denom;
        if (r > 0) {
            if (s <= 256 && s >= 0) {
                return true;
            }
        }
        return false;
    }
    ivec2 pos1, pos2;
    fixed tex1, tex2;
    ivec2 wPos1, wPos2;
};

inline int min(int a, int b) {
    if (a < b) {
        return a;
    }
    return b;
}

#endif