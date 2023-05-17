// #include "fixed.h"

// fixed PI = 804;

// // theta is in radians
// fixed f_cos(fixed theta) {
//     if ((theta / PI) % 2 == 0) {
//         return cosTable[theta % PI];
//     } else if ((theta / PI) % 2 == 0) {
//         return -cosTable[theta % PI];
//     }
// }
// fixed f_sin(fixed theta) {
//     theta += PI / 2;
//     if ((theta / PI) % 2 == 0) {
//         return cosTable[theta % PI];
//     } else if ((theta / PI) % 2 == 0) {
//         return -cosTable[theta % PI];
//     }
// }
// fixed f_tan(fixed theta) {}