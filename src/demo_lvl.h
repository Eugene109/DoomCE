#ifndef DEMO_LVL
#define DEMO_LVL

#include "aa_lines.h"

#ifndef __cplusplus
assert(0);
#endif

const uint8_t DEMO_NUM_LINES = 10;
AA_Line demo_lines[DEMO_NUM_LINES] = {AA_Line(X_LINE, 10, -10, 7, 0, 17),  AA_Line(Y_LINE, 7, 7, 10, 0, 3),
                                      AA_Line(X_LINE, 7, 7, 10, 0, 3),     AA_Line(Y_LINE, 10, -10, 7, 0, 17),

                                      AA_Line(X_LINE, -10, -7, 10, 0, 17), AA_Line(Y_LINE, -7, -10, -7, 0, 3),
                                      AA_Line(X_LINE, -7, -10, -7, 0, 3),  AA_Line(Y_LINE, -10, -7, 10, 0, 17),

                                      AA_Line(X_LINE, 7, -5, 2, 0, 7),     AA_Line(Y_LINE, 7, -5, 2, 0, 7)};

#endif
