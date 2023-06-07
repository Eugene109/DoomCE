#ifndef AA_LINES_H
#define AA_LINES_H
// Axis-Aligned line segments
// axis-alighed: MUCH faster and easy raycasting
// possible optimizations:
//   - split X and Y lines
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

enum LineType { X_LINE, Y_LINE };
class AA_Line {
  public:
    AA_Line(LineType X_Y_line, double off, double min, double max, double t1, double t2) {
        type = X_Y_line;
        pos = off * (1 << SHIFT);
        min_value = min * (1 << SHIFT);
        max_value = max * (1 << SHIFT);
        tex1 = t1 * (1 << SHIFT);
        tex2 = t2 * (1 << SHIFT);
        wPos = pos;
        wMin_value = min_value;
        wMax_value = max_value;
    }
    bool rayIntersection(const ivec2 &ray, ivec2 *hit, fixed *texCoord) {
        if (type == X_LINE) {
            if ((ray.y <= DELTA) && (ray.y >= -DELTA)) {
                return false;
            }
            fixed mult = (pos << SHIFT) / ray.y;
            if (mult >= DELTA) {
                fixed xPos = (ray.x * mult) >> SHIFT;
                if (min_value <= xPos + DELTA && xPos - DELTA <= max_value) {
                    // dbg_printf("hiiii");
                    *hit = ivec2(xPos, pos);
                    if (texCoord != nullptr) {
                        *texCoord =
                            ((((xPos - min_value) << SHIFT) / (max_value - min_value) * (tex2 - tex1)) >> SHIFT) + tex1;
                    }
                    return true;
                } else {
                    return false;
                }
            }
            return false;
        } else if (type == Y_LINE) {
            if ((ray.x <= DELTA) && (ray.x >= -DELTA)) {
                return false;
            }
            fixed mult = (pos << SHIFT) / ray.x;
            if (mult >= DELTA) {
                fixed yPos = (ray.y * mult) >> SHIFT;
                if (min_value <= yPos + DELTA && yPos - DELTA <= max_value) {
                    *hit = ivec2(pos, yPos);
                    if (texCoord != nullptr) {
                        *texCoord =
                            ((((yPos - min_value) << SHIFT) / (max_value - min_value) * (tex2 - tex1)) >> SHIFT) + tex1;
                    }
                    return true;
                } else {
                    return false;
                }
            }
            return false;
        }
        assert(0);
        return false;
    }
    LineType type;
    fixed pos;
    fixed min_value, max_value;
    fixed tex1, tex2;
    fixed wPos;
    fixed wMin_value, wMax_value;
};

inline int min(int a, int b) {
    if (a < b) {
        return a;
    }
    return b;
}

int aa_comp(const void *a, const void *b) {
    int a_pos_sq = (((((AA_Line *)a)->pos) * (((AA_Line *)a)->pos)) >> SHIFT);
    int b_pos_sq = (((((AA_Line *)b)->pos) * (((AA_Line *)b)->pos)) >> SHIFT);
    int a_val = min(abs(((AA_Line *)a)->min_value), abs(((AA_Line *)a)->max_value));
    int b_val = min(abs(((AA_Line *)b)->min_value), abs(((AA_Line *)b)->max_value));
    return (a_pos_sq + ((a_val * a_val) >> SHIFT)) - (b_pos_sq + ((b_val * b_val) >> SHIFT));
}
int aa_single_comp(const void *a, const void *b) { return abs(((AA_Line *)a)->pos) - abs(((AA_Line *)b)->pos); }

#endif