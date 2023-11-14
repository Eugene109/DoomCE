#ifndef VECTOR_MATH_H
#define VECTOR_MATH_H

// #include <iostream>
// #include <vector>
#include <cmath>
// #include <string>
// #include <chrono>
// #include <algorithm>
// #include <array>
// #include <sstream>
// #include <iomanip>

#include "fixed.h"

using namespace std;

// class vec2 {
//   public:
//     vec2() : x(0), y(0) {}
//     vec2(double x_in, double y_in) : x(x_in), y(y_in) {}
//     vec2(double in) : x(in), y(in) {}

//     double operator[](unsigned i) {
//         switch (i) {
//         case 0:
//             return x;
//         case 1:
//             return y;
//         default:
//             return 6969696969.69;
//         }
//     }

//     vec2 operator*(const double &a) { return vec2(x * a, y * a); }
//     void operator*=(double a) { // or this
//         x *= a;
//         y *= a;
//     }
//     vec2 operator/(const double &a) { return vec2(x / a, y / a); }
//     const vec2 operator/(const double &a) const { return vec2(x / a, y / a); }
//     void operator/=(double a) { // or this
//         x /= a;
//         y /= a;
//     }

//     const vec2 operator+(const vec2 &a) const { return vec2(x + a.x, y + a.y); }

//     vec2 operator+(const vec2 &a) { return vec2(x + a.x, y + a.y); }

//     vec2 operator+(double a) { return vec2(x + a, y + a); }
//     void operator+=(vec2 a) {
//         x += a.x;
//         y += a.y;
//     }

//     const vec2 operator-(const vec2 &a) const { return vec2(x - a.x, y - a.y); }

//     vec2 operator-(const vec2 &a) { return vec2(x - a.x, y - a.y); }
//     vec2 operator-(double a) { return vec2(x - a, y - a); }
//     void operator-=(vec2 a) {
//         x -= a.x;
//         y -= a.y;
//     }

//     double x;
//     double y;
// };

// vec2 operator*(double a, vec2 b) { return b * a; }

class ivec2 {
  public:
    ivec2() : x(0), y(0) {}
    ivec2(int x_in, int y_in) : x(x_in), y(y_in) {}
    ivec2(int in) : x(in), y(in) {}

    double operator[](unsigned i) {
        switch (i) {
        case 0:
            return x;
        case 1:
            return y;
        default:
            return 6969696969.69;
        }
    }

    ivec2 operator*(int a) { return ivec2((x * a) >> SHIFT, (y * a) >> SHIFT); }
    const ivec2 operator*(int a) const { return ivec2((x * a) >> SHIFT, (y * a) >> SHIFT); }
    ivec2 operator/(int a) { return ivec2((x << SHIFT) / a, (y << SHIFT) / a); }
    const ivec2 operator/(int a) const { return ivec2((x << SHIFT) / a, (y << SHIFT) / a); }

    const ivec2 operator+(const ivec2 &a) const { return ivec2(x + a.x, y + a.y); }
    ivec2 operator+(const ivec2 &a) { return ivec2(x + a.x, y + a.y); }
    ivec2 operator+(int a) { return ivec2(x + a, y + a); }

    const ivec2 operator-(const ivec2 &a) const { return ivec2(x - a.x, y - a.y); }
    ivec2 operator-(const ivec2 &a) { return ivec2(x - a.x, y - a.y); }
    ivec2 operator-(int a) { return ivec2(x - a, y - a); }

    void operator*=(int a) { // or this
        x *= a;
        y *= a;
        x = x >> SHIFT;
        y = y >> SHIFT;
    }
    void operator/=(int a) { // or this
        x = x << SHIFT;
        y = y << SHIFT;
        x /= a;
        y /= a;
    }
    void operator+=(ivec2 a) {
        x += a.x;
        y += a.y;
    }
    void operator-=(ivec2 a) {
        x -= a.x;
        y -= a.y;
    }

    int x;
    int y;
};

ivec2 operator*(int a, ivec2 b) { return b * a; }

unsigned inv_sqrt_lut_lsb[256] = {
    0xFFFFFF, 4096, 2896, 2364, 2048, 1831, 1672, 1548, 1448, 1365, 1295, 1234, 1182, 1136, 1094, 1057, 1024, 993, 965,
    939,      915,  893,  873,  854,  836,  819,  803,  788,  774,  760,  747,  735,  724,  713,  702,  692,  682, 673,
    664,      655,  647,  639,  632,  624,  617,  610,  603,  597,  591,  585,  579,  573,  568,  562,  557,  552, 547,
    542,      537,  533,  528,  524,  520,  516,  512,  508,  504,  500,  496,  493,  489,  486,  482,  479,  476, 472,
    469,      466,  463,  460,  457,  455,  452,  449,  446,  444,  441,  439,  436,  434,  431,  429,  427,  424, 422,
    420,      418,  415,  413,  411,  409,  407,  405,  403,  401,  399,  397,  395,  394,  392,  390,  388,  387, 385,
    383,      381,  380,  378,  377,  375,  373,  372,  370,  369,  367,  366,  364,  363,  362,  360,  359,  357, 356,
    355,      353,  352,  351,  349,  348,  347,  346,  344,  343,  342,  341,  340,  338,  337,  336,  335,  334, 333,
    332,      331,  330,  328,  327,  326,  325,  324,  323,  322,  321,  320,  319,  318,  317,  316,  316,  315, 314,
    313,      312,  311,  310,  309,  308,  307,  307,  306,  305,  304,  303,  302,  301,  301,  300,  299,  298, 297,
    297,      296,  295,  294,  294,  293,  292,  291,  291,  290,  289,  288,  288,  287,  286,  286,  285,  284, 284,
    283,      282,  281,  281,  280,  279,  279,  278,  278,  277,  276,  276,  275,  274,  274,  273,  273,  272, 271,
    271,      270,  270,  269,  268,  268,  267,  267,  266,  266,  265,  264,  264,  263,  263,  262,  262,  261, 261,
    260,      260,  259,  259,  258,  258,  257,  257,  256,
};

unsigned inv_sqrt_lut[256] = {
    0xFFFFFF, 256, 181, 147, 128, 114, 104, 96, 90, 85, 80, 77, 73, 71, 68, 66, 64, 62, 60, 58, 57, 55, 54, 53, 52, 51,
    50,       49,  48,  47,  46,  45,  45,  44, 43, 43, 42, 42, 41, 40, 40, 39, 39, 39, 38, 38, 37, 37, 36, 36, 36, 35,
    35,       35,  34,  34,  34,  33,  33,  33, 33, 32, 32, 32, 32, 31, 31, 31, 31, 30, 30, 30, 30, 29, 29, 29, 29, 29,
    28,       28,  28,  28,  28,  28,  27,  27, 27, 27, 27, 27, 26, 26, 26, 26, 26, 26, 26, 25, 25, 25, 25, 25, 25, 25,
    25,       24,  24,  24,  24,  24,  24,  24, 24, 24, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 22, 22, 22, 22, 22, 22,
    22,       22,  22,  22,  22,  22,  21,  21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 20, 20, 20, 20, 20, 20, 20,
    20,       20,  20,  20,  20,  20,  20,  20, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
    18,       18,  18,  18,  18,  18,  18,  18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 17, 17, 17, 17, 17,
    17,       17,  17,  17,  17,  17,  17,  17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 16, 16, 16, 16, 16, 16, 16,
    16,       16,  16,  16,  16,  16,  16,  16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
};

fixed inv_sqrt(fixed number) {
    if (number >> SHIFT == 0) {
        return inv_sqrt_lut_lsb[number];
    }
    fixed y = inv_sqrt_lut[number >> SHIFT];
    int x = number;
    // 0.703952253f * ( 2.38924456f - x * conv.f * conv.f );
    y = (y * ((0xB4 * (0x264 - ((((x * y) >> SHIFT) * y) >> SHIFT))) >> SHIFT)) >> SHIFT;
    y = (y * ((0xB4 * (0x264 - ((((x * y) >> SHIFT) * y) >> SHIFT))) >> SHIFT)) >> SHIFT;
    y = (y * ((0xB4 * (0x264 - ((((x * y) >> SHIFT) * y) >> SHIFT))) >> SHIFT)) >> SHIFT;
    return y;
}

ivec2 normalize(const ivec2 &in) {
    int inv_len = inv_sqrt((in.x >> 4) * (in.x >> 4) + (in.y >> 4) * (in.y >> 4));
    return ivec2((in.x * inv_len) >> SHIFT, (in.y * inv_len) >> SHIFT);
}

fixed lengthSQ(const ivec2 &in) { return ((in.x * in.x) >> SHIFT) + ((in.y * in.y) >> SHIFT); }

class vec3 {
  public:
    vec3() : x(0), y(0), z(0) {}
    vec3(double x_in, double y_in, double z_in) : x(x_in), y(y_in), z(z_in) {}
    vec3(double in) : x(in), y(in), z(in) {}

    // vec2 xy() { return vec2(x, y); }

    double operator[](unsigned i) {
        switch (i) {
        case 0:
            return x;
        case 1:
            return y;
        case 2:
            return z;
        default:
            return 6969696969.69;
        }
    }

    vec3 operator*(const double &a) { return vec3(x * a, y * a, z * a); }
    const vec3 operator*(const double &a) const { return vec3(x * a, y * a, z * a); }
    vec3 operator*(const vec3 &a) { return vec3(x * a.x, y * a.y, z * a.z); }
    const vec3 operator*(const vec3 &a) const { return vec3(x * a.x, y * a.y, z * a.z); }
    void operator*=(double a) { // or this
        x *= a;
        y *= a;
        z *= a;
    }
    vec3 operator/(const double &a) { return vec3(x / a, y / a, z / a); }
    const vec3 operator/(const double &a) const { return vec3(x / a, y / a, z / a); }
    void operator/=(double a) { // or this
        x /= a;
        y /= a;
        z /= a;
    }

    vec3 operator+(const vec3 &a) { return vec3(x + a.x, y + a.y, z + a.z); }
    const vec3 operator+(const vec3 &a) const { return vec3(x + a.x, y + a.y, z + a.z); }
    void operator+=(vec3 a) {
        x += a.x;
        y += a.y;
        z += a.z;
    }

    vec3 operator-() { return vec3(-x, -y, -z); }

    vec3 operator-(const vec3 &a) { return vec3(x - a.x, y - a.y, z - a.z); }
    void operator-=(vec3 a) {
        x -= a.x;
        y -= a.y;
        z -= a.z;
    }

    double x;
    double y;
    double z;
};

vec3 operator*(double a, const vec3 &b) { return b * a; }
vec3 operator-(double a, const vec3 &b) { return vec3(a) - b; }
vec3 operator+(double a, const vec3 &b) { return b + a; }

vec3 pow(const vec3 &base, double e) { return vec3(pow(base.x, e), pow(base.y, e), pow(base.z, e)); }

class vec4 {
  public:
    vec4() : x(0), y(0), z(0), w(0) {}
    vec4(vec3 in, double w_in) : x(in.x), y(in.y), z(in.z), w(w_in) {}
    vec4(double x_in, double y_in, double z_in, double w_in) : x(x_in), y(y_in), z(z_in), w(w_in) {}
    vec4(double in) : x(in), y(in), z(in), w(in) {}

    // vec2 xy() { return vec2(x, y); }
    // vec3 xyz() { return vec3(x, y, z); }

    double operator[](unsigned i) {
        switch (i) {
        case 0:
            return x;
        case 1:
            return y;
        case 2:
            return z;
        case 3:
            return w;
        default:
            return 6969696969.69;
        }
    }

    vec4 operator*(const double &a) { return vec4(x * a, y * a, z * a, w * a); }
    const vec4 operator*(const double &a) const { return vec4(x * a, y * a, z * a, w * a); }
    void operator*=(double a) { // or this
        x *= a;
        y *= a;
        z *= a;
        w *= a;
    }
    vec4 operator/(const double &a) { return vec4(x / a, y / a, z / a, w / a); }
    void operator/=(double a) { // or this
        x /= a;
        y /= a;
        z /= a;
        w /= a;
    }

    vec4 operator+(const vec4 &a) { return vec4(x + a.x, y + a.y, z + a.z, w + a.w); }
    void operator+=(const vec4 &a) {
        x += a.x;
        y += a.y;
        z += a.z;
        w += a.z;
    }

    vec4 operator-(const vec4 &a) { return vec4(x - a.x, y - a.y, z - a.z, w - a.w); }
    void operator-=(const vec4 &a) {
        x -= a.x;
        y -= a.y;
        z -= a.z;
        w -= a.w;
    }

    double x;
    double y;
    double z;
    double w;
};

vec3 cross(const vec3 &a, const vec3 &b) {
    return vec3(a.y * b.z - a.z * b.y, -1 * (a.x * b.z - a.z * b.x), a.x * b.y - a.y * b.x);
}

vec4 operator*(double a, const vec4 &b) { return b * a; }

// double dot(const vec2 &a, const vec2 &b) { return a.x * b.x + a.y * b.y; }
int dot(const ivec2 &a, const ivec2 &b) { return (a.x * b.x + a.y * b.y) >> SHIFT; }
double dot(const vec3 &a, const vec3 &b) { return a.x * b.x + a.y * b.y + a.z * b.z; }

// void printVec4(vec4 a){
//     cout << std::fixed << std::setprecision(5);
//     cout << a.x << " " << a.y << " " << a.z << " " << a.w << "\n";
// }
// void printVec3(vec3 a){
//     cout << std::fixed << std::setprecision(5);
//     cout << a.x << " " << a.y << " " << a.z << "\n";
// }
// void printVec2(vec2 a){
//     cout << std::fixed << std::setprecision(5);
//     cout << a.x << " " << a.y << "\n";
// }

// double min(double a, double b) {
//     if (a > b) {
//         return b;
//     }
//     return a;
// }
// double max(double a, double b) {
//     if (a < b) {
//         return b;
//     }
//     return a;
// }

inline int max(int a, int b) {
    if (a < b) {
        return b;
    }
    return a;
}
vec3 normalize(const vec3 &in) {
    double length = sqrt(in.x * in.x + in.y * in.y + in.z * in.z);
    return in / length;
}

// vec2 normalize(const vec2 &in) {
//     double length = sqrt(in.x * in.x + in.y * in.y);
//     return in / length;
// }

double lengthSQ(const vec3 &in) { return in.x * in.x + in.y * in.y + in.z * in.z; }
// double lengthSQ(const vec2 &in) { return in.x * in.x + in.y * in.y; }

float clamp(double in, double min = 0, double max = 1) {
    if (in < min) {
        return min;
    }
    if (in > max) {
        return max;
    }
    return in;
}

#endif