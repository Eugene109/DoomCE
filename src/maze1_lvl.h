#ifndef MAZE1_LVL
#define MAZE1_LVL

#include "aa_lines.h"

#ifndef __cplusplus
assert(0);
#endif

const uint8_t MAZE1_NUM_LINES = 25;
AA_Line maze1_lines[MAZE1_NUM_LINES] = {

    AA_Line(X_LINE, 12, -7, 22, 0, 29), AA_Line(X_LINE, 10, -4, 13, 0, 17), AA_Line(X_LINE, 10, 4, 22, 0, 18),
    AA_Line(X_LINE, 9, -7, 8, 0, 15),   AA_Line(X_LINE, 7, -4, 20, 0, 24),  AA_Line(X_LINE, 6, -5, 10, 0, 15),
    AA_Line(X_LINE, 5, 3, 20, 0, 17),   AA_Line(X_LINE, 3, 5, 22, 0, 17),   AA_Line(X_LINE, 1, 0, 15, 0, 15),
    AA_Line(X_LINE, 1, 5, 20, 0, 15),   AA_Line(X_LINE, -1, -7, 10, 0, 17), AA_Line(X_LINE, -1, 1, 19, 0, 18),
    AA_Line(X_LINE, -3, -7, 22, 0, 29), AA_Line(Y_LINE, -7, -4, 12, 0, 16), AA_Line(Y_LINE, -5, -2, 0, 0, 2),
    AA_Line(Y_LINE, -4, 1, 7, 0, 6),    AA_Line(Y_LINE, -3, 8, 10, 0, 2),   AA_Line(Y_LINE, -2, 9, 12, 0, 3),
    AA_Line(Y_LINE, -2, -4, 4, 0, 8),   AA_Line(Y_LINE, -1, 5, 7, 0, 2),    AA_Line(Y_LINE, 1, 6, 12, 0, 6),
    AA_Line(Y_LINE, 1, -4, 4, 0, 8),    AA_Line(Y_LINE, 3, 0, 7, 0, 7),     AA_Line(Y_LINE, 6, 6, 8, 0, 2),
    AA_Line(Y_LINE, 8, -4, 12, 0, 16),
};

const uint8_t MAZE1_NUM_X_LINES = 13;
AA_Line maze1_x_lines[MAZE1_NUM_X_LINES] = {

    AA_Line(X_LINE, 12, -7, 22, 0, 29), AA_Line(X_LINE, 10, -4, 13, 0, 17), AA_Line(X_LINE, 10, 4, 22, 0, 18),
    AA_Line(X_LINE, 9, -7, 8, 0, 15),   AA_Line(X_LINE, 7, -4, 20, 0, 24),  AA_Line(X_LINE, 6, -5, 10, 0, 15),
    AA_Line(X_LINE, 5, 3, 20, 0, 17),   AA_Line(X_LINE, 3, 5, 22, 0, 17),   AA_Line(X_LINE, 1, 0, 15, 0, 15),
    AA_Line(X_LINE, 1, 5, 20, 0, 15),   AA_Line(X_LINE, -1, -7, 10, 0, 17), AA_Line(X_LINE, -1, 1, 19, 0, 18),
    AA_Line(X_LINE, -3, -7, 22, 0, 29),
};

const uint8_t MAZE1_NUM_Y_LINES = 12;
AA_Line maze1_y_lines[MAZE1_NUM_Y_LINES] = {
    AA_Line(Y_LINE, -7, -4, 12, 0, 16), AA_Line(Y_LINE, -5, -2, 0, 0, 2), AA_Line(Y_LINE, -4, 1, 7, 0, 6),
    AA_Line(Y_LINE, -3, 8, 10, 0, 2),   AA_Line(Y_LINE, -2, 9, 12, 0, 3), AA_Line(Y_LINE, -2, -4, 4, 0, 8),
    AA_Line(Y_LINE, -1, 5, 7, 0, 2),    AA_Line(Y_LINE, 1, 6, 12, 0, 6),  AA_Line(Y_LINE, 1, -4, 4, 0, 8),
    AA_Line(Y_LINE, 3, 0, 7, 0, 7),     AA_Line(Y_LINE, 6, 6, 8, 0, 2),   AA_Line(Y_LINE, 8, -4, 12, 0, 16),
};

#endif