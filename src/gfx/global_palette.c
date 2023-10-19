unsigned char global_palette[512] =
{
    0x00, 0x00, /*   0: rgb(  0,   0,   0) */
    0x1f, 0x7c, /*   1: rgb(255,   0, 255) */
    0x01, 0xfc, /*   2: rgb(255,   4,   8) */
    0x00, 0x00, /*   3: rgb(  0,   0,   0) */
    0x00, 0x04, /*   4: rgb(  8,   0,   0) */
    0x21, 0x04, /*   5: rgb(  8,   8,   8) */
    0x21, 0x88, /*   6: rgb( 16,  12,   8) */
    0x42, 0x8c, /*   7: rgb( 25,  20,  16) */
    0x63, 0x8c, /*   8: rgb( 25,  28,  25) */
    0x41, 0x10, /*   9: rgb( 33,  16,   8) */
    0x62, 0x10, /*  10: rgb( 33,  24,  16) */
    0x63, 0x90, /*  11: rgb( 33,  28,  25) */
    0x81, 0x10, /*  12: rgb( 33,  32,   8) */
    0x84, 0x10, /*  13: rgb( 33,  32,  33) */
    0x84, 0x90, /*  14: rgb( 33,  36,  33) */
    0x23, 0x91, /*  15: rgb( 33,  77,  25) */
    0x82, 0x14, /*  16: rgb( 41,  32,  16) */
    0xa4, 0x14, /*  17: rgb( 41,  40,  33) */
    0xa5, 0x14, /*  18: rgb( 41,  40,  41) */
    0xa5, 0x94, /*  19: rgb( 41,  45,  41) */
    0xa2, 0x18, /*  20: rgb( 49,  40,  16) */
    0xa4, 0x98, /*  21: rgb( 49,  45,  33) */
    0xc6, 0x18, /*  22: rgb( 49,  49,  49) */
    0xc6, 0x98, /*  23: rgb( 49,  53,  49) */
    0x85, 0x99, /*  24: rgb( 49, 101,  41) */
    0xa3, 0x9c, /*  25: rgb( 58,  45,  25) */
    0xc7, 0x9c, /*  26: rgb( 58,  53,  58) */
    0xe7, 0x1c, /*  27: rgb( 58,  57,  58) */
    0xe4, 0x9c, /*  28: rgb( 58,  61,  33) */
    0xe7, 0x9c, /*  29: rgb( 58,  61,  58) */
    0x00, 0x20, /*  30: rgb( 66,   0,   0) */
    0x62, 0xa0, /*  31: rgb( 66,  28,  16) */
    0xc3, 0x20, /*  32: rgb( 66,  49,  25) */
    0xc4, 0xa0, /*  33: rgb( 66,  53,  33) */
    0x08, 0x21, /*  34: rgb( 66,  65,  66) */
    0x08, 0xa1, /*  35: rgb( 66,  69,  66) */
    0x26, 0x21, /*  36: rgb( 66,  73,  49) */
    0xa3, 0x24, /*  37: rgb( 74,  40,  25) */
    0xc4, 0x24, /*  38: rgb( 74,  49,  33) */
    0xe4, 0x24, /*  39: rgb( 74,  57,  33) */
    0xe5, 0x24, /*  40: rgb( 74,  57,  41) */
    0xe5, 0xa4, /*  41: rgb( 74,  61,  41) */
    0x29, 0x25, /*  42: rgb( 74,  73,  74) */
    0x29, 0xa5, /*  43: rgb( 74,  77,  74) */
    0x49, 0x25, /*  44: rgb( 74,  81,  74) */
    0x46, 0xa5, /*  45: rgb( 74,  85,  49) */
    0x00, 0xa8, /*  46: rgb( 82,   4,   0) */
    0x8a, 0xa8, /*  47: rgb( 82,  36,  82) */
    0xe4, 0xa8, /*  48: rgb( 82,  61,  33) */
    0x06, 0x29, /*  49: rgb( 82,  65,  49) */
    0x08, 0xa9, /*  50: rgb( 82,  69,  66) */
    0x4a, 0x29, /*  51: rgb( 82,  81,  82) */
    0x47, 0xa9, /*  52: rgb( 82,  85,  58) */
    0x4a, 0xa9, /*  53: rgb( 82,  85,  82) */
    0x6a, 0x29, /*  54: rgb( 82,  89,  82) */
    0x62, 0x2c, /*  55: rgb( 90,  24,  16) */
    0x83, 0xac, /*  56: rgb( 90,  36,  25) */
    0x04, 0x2d, /*  57: rgb( 90,  65,  33) */
    0x26, 0x2d, /*  58: rgb( 90,  73,  49) */
    0x4a, 0xad, /*  59: rgb( 90,  85,  82) */
    0x4b, 0xad, /*  60: rgb( 90,  85,  90) */
    0x4d, 0xad, /*  61: rgb( 90,  85, 107) */
    0x6b, 0x2d, /*  62: rgb( 90,  89,  90) */
    0x6e, 0x2d, /*  63: rgb( 90,  89, 115) */
    0x68, 0xad, /*  64: rgb( 90,  93,  66) */
    0x6b, 0xad, /*  65: rgb( 90,  93,  90) */
    0x21, 0x30, /*  66: rgb( 99,   8,   8) */
    0xa4, 0xb0, /*  67: rgb( 99,  45,  33) */
    0xc5, 0xb0, /*  68: rgb( 99,  53,  41) */
    0x04, 0xb1, /*  69: rgb( 99,  69,  33) */
    0x27, 0xb1, /*  70: rgb( 99,  77,  58) */
    0x6b, 0xb1, /*  71: rgb( 99,  93,  90) */
    0x6d, 0xb1, /*  72: rgb( 99,  93, 107) */
    0x8c, 0x31, /*  73: rgb( 99,  97,  99) */
    0x8c, 0xb1, /*  74: rgb( 99, 101,  99) */
    0xa9, 0xb1, /*  75: rgb( 99, 109,  74) */
    0xe5, 0x34, /*  76: rgb(107,  57,  41) */
    0x07, 0xb5, /*  77: rgb(107,  69,  58) */
    0x25, 0x35, /*  78: rgb(107,  73,  41) */
    0x48, 0xb5, /*  79: rgb(107,  85,  66) */
    0x4b, 0xb5, /*  80: rgb(107,  85,  90) */
    0x8e, 0x35, /*  81: rgb(107,  97, 115) */
    0x89, 0xb5, /*  82: rgb(107, 101,  74) */
    0x8e, 0xb5, /*  83: rgb(107, 101, 115) */
    0xad, 0x35, /*  84: rgb(107, 105, 107) */
    0xb0, 0x35, /*  85: rgb(107, 105, 132) */
    0xad, 0xb5, /*  86: rgb(107, 109, 107) */
    0xca, 0xb5, /*  87: rgb(107, 117,  82) */
    0x00, 0x38, /*  88: rgb(115,   0,   0) */
    0x41, 0x38, /*  89: rgb(115,  16,   8) */
    0x63, 0xb8, /*  90: rgb(115,  28,  25) */
    0xa4, 0xb8, /*  91: rgb(115,  45,  33) */
    0xc5, 0xb8, /*  92: rgb(115,  53,  41) */
    0x06, 0x39, /*  93: rgb(115,  65,  49) */
    0x25, 0xb9, /*  94: rgb(115,  77,  41) */
    0x28, 0xb9, /*  95: rgb(115,  77,  66) */
    0x69, 0x39, /*  96: rgb(115,  89,  74) */
    0x8c, 0xb9, /*  97: rgb(115, 101,  99) */
    0xaf, 0x39, /*  98: rgb(115, 105, 123) */
    0xce, 0x39, /*  99: rgb(115, 113, 115) */
    0xd1, 0x39, /* 100: rgb(115, 113, 140) */
    0xce, 0xb9, /* 101: rgb(115, 117, 115) */
    0x29, 0x3a, /* 102: rgb(115, 138,  74) */
    0x00, 0x3c, /* 103: rgb(123,   0,   0) */
    0x45, 0x3d, /* 104: rgb(123,  81,  41) */
    0x47, 0xbd, /* 105: rgb(123,  85,  58) */
    0x89, 0x3d, /* 106: rgb(123,  97,  74) */
    0xa9, 0x3d, /* 107: rgb(123, 105,  74) */
    0xef, 0x3d, /* 108: rgb(123, 121, 123) */
    0xf2, 0x3d, /* 109: rgb(123, 121, 148) */
    0xec, 0xbd, /* 110: rgb(123, 125,  99) */
    0xef, 0xbd, /* 111: rgb(123, 125, 123) */
    0xf3, 0xbd, /* 112: rgb(123, 125, 156) */
    0x46, 0xc1, /* 113: rgb(132,  85,  49) */
    0x8a, 0x41, /* 114: rgb(132,  97,  82) */
    0xaa, 0x41, /* 115: rgb(132, 105,  82) */
    0x12, 0x42, /* 116: rgb(132, 130, 148) */
    0x10, 0xc2, /* 117: rgb(132, 134, 132) */
    0x00, 0x44, /* 118: rgb(140,   0,   0) */
    0x20, 0xc4, /* 119: rgb(140,  12,   0) */
    0x40, 0xc4, /* 120: rgb(140,  20,   0) */
    0x84, 0x44, /* 121: rgb(140,  32,  33) */
    0xc5, 0x44, /* 122: rgb(140,  49,  41) */
    0xe6, 0xc4, /* 123: rgb(140,  61,  49) */
    0x27, 0x45, /* 124: rgb(140,  73,  58) */
    0x66, 0x45, /* 125: rgb(140,  89,  49) */
    0xcb, 0x45, /* 126: rgb(140, 113,  90) */
    0xcd, 0xc5, /* 127: rgb(140, 117, 107) */
    0xf0, 0x45, /* 128: rgb(140, 121, 132) */
    0x13, 0xc6, /* 129: rgb(140, 134, 156) */
    0x31, 0x46, /* 130: rgb(140, 138, 140) */
    0x34, 0x46, /* 131: rgb(140, 138, 165) */
    0x20, 0xc8, /* 132: rgb(148,  12,   0) */
    0x40, 0xc8, /* 133: rgb(148,  20,   0) */
    0x60, 0xc8, /* 134: rgb(148,  28,   0) */
    0xc5, 0x48, /* 135: rgb(148,  49,  41) */
    0xe5, 0xc8, /* 136: rgb(148,  61,  41) */
    0x49, 0xc9, /* 137: rgb(148,  85,  74) */
    0x67, 0xc9, /* 138: rgb(148,  93,  58) */
    0x87, 0x49, /* 139: rgb(148,  97,  58) */
    0x8a, 0x49, /* 140: rgb(148,  97,  82) */
    0xab, 0x49, /* 141: rgb(148, 105,  90) */
    0xea, 0x49, /* 142: rgb(148, 121,  82) */
    0xed, 0xc9, /* 143: rgb(148, 125, 107) */
    0x52, 0x4a, /* 144: rgb(148, 146, 148) */
    0x54, 0x4a, /* 145: rgb(148, 146, 165) */
    0x52, 0xca, /* 146: rgb(148, 150, 148) */
    0x00, 0x4c, /* 147: rgb(156,   0,   0) */
    0x80, 0x4c, /* 148: rgb(156,  32,   0) */
    0xa0, 0x4c, /* 149: rgb(156,  40,   0) */
    0xa1, 0xcc, /* 150: rgb(156,  45,   8) */
    0xc3, 0xcc, /* 151: rgb(156,  53,  25) */
    0x27, 0x4d, /* 152: rgb(156,  73,  58) */
    0x87, 0xcd, /* 153: rgb(156, 101,  58) */
    0xa8, 0x4d, /* 154: rgb(156, 105,  66) */
    0xcc, 0xcd, /* 155: rgb(156, 117,  99) */
    0x0c, 0xce, /* 156: rgb(156, 134,  99) */
    0x0e, 0xce, /* 157: rgb(156, 134, 115) */
    0x2e, 0xce, /* 158: rgb(156, 142, 115) */
    0x31, 0xce, /* 159: rgb(156, 142, 140) */
    0x74, 0x4e, /* 160: rgb(156, 154, 165) */
    0x75, 0x4e, /* 161: rgb(156, 154, 173) */
    0x76, 0x4e, /* 162: rgb(156, 154, 181) */
    0x73, 0xce, /* 163: rgb(156, 158, 156) */
    0x76, 0xce, /* 164: rgb(156, 158, 181) */
    0x93, 0x4e, /* 165: rgb(156, 162, 156) */
    0x00, 0x50, /* 166: rgb(165,   0,   0) */
    0xc0, 0xd0, /* 167: rgb(165,  53,   0) */
    0xe7, 0x50, /* 168: rgb(165,  57,  58) */
    0xe3, 0xd0, /* 169: rgb(165,  61,  25) */
    0xa8, 0x51, /* 170: rgb(165, 105,  66) */
    0xa8, 0xd1, /* 171: rgb(165, 109,  66) */
    0xcc, 0x51, /* 172: rgb(165, 113,  99) */
    0xee, 0x51, /* 173: rgb(165, 121, 115) */
    0x2d, 0xd2, /* 174: rgb(165, 142, 107) */
    0x96, 0x52, /* 175: rgb(165, 162, 181) */
    0x97, 0xd2, /* 176: rgb(165, 166, 189) */
    0x05, 0x55, /* 177: rgb(173,  65,  41) */
    0x03, 0xd5, /* 178: rgb(173,  69,  25) */
    0x08, 0xd5, /* 179: rgb(173,  69,  66) */
    0x47, 0x55, /* 180: rgb(173,  81,  58) */
    0x89, 0x55, /* 181: rgb(173,  97,  74) */
    0xa8, 0xd5, /* 182: rgb(173, 109,  66) */
    0xc8, 0x55, /* 183: rgb(173, 113,  66) */
    0x4f, 0x56, /* 184: rgb(173, 146, 123) */
    0x50, 0xd6, /* 185: rgb(173, 150, 132) */
    0x6e, 0x56, /* 186: rgb(173, 154, 115) */
    0x92, 0x56, /* 187: rgb(173, 162, 148) */
    0xb5, 0x56, /* 188: rgb(173, 170, 173) */
    0xb8, 0xd6, /* 189: rgb(173, 174, 197) */
    0x00, 0x58, /* 190: rgb(181,   0,   0) */
    0x42, 0xd8, /* 191: rgb(181,  20,  16) */
    0xa4, 0x58, /* 192: rgb(181,  40,  33) */
    0xc4, 0xd8, /* 193: rgb(181,  53,  33) */
    0x47, 0xd9, /* 194: rgb(181,  85,  58) */
    0x4a, 0xd9, /* 195: rgb(181,  85,  82) */
    0x86, 0x59, /* 196: rgb(181,  97,  49) */
    0xc9, 0x59, /* 197: rgb(181, 113,  74) */
    0xc9, 0xd9, /* 198: rgb(181, 117,  74) */
    0x0e, 0x5a, /* 199: rgb(181, 130, 115) */
    0x71, 0x5a, /* 200: rgb(181, 154, 140) */
    0xd6, 0xda, /* 201: rgb(181, 182, 181) */
    0xda, 0xda, /* 202: rgb(181, 182, 214) */
    0x25, 0x5d, /* 203: rgb(189,  73,  41) */
    0x8b, 0x5d, /* 204: rgb(189,  97,  90) */
    0xac, 0xdd, /* 205: rgb(189, 109,  99) */
    0xe9, 0x5d, /* 206: rgb(189, 121,  74) */
    0x91, 0x5e, /* 207: rgb(189, 162, 140) */
    0xb2, 0x5e, /* 208: rgb(189, 170, 148) */
    0x05, 0x61, /* 209: rgb(197,  65,  41) */
    0x24, 0x61, /* 210: rgb(197,  73,  33) */
    0x25, 0x61, /* 211: rgb(197,  73,  41) */
    0x25, 0xe1, /* 212: rgb(197,  77,  41) */
    0x45, 0x61, /* 213: rgb(197,  81,  41) */
    0x68, 0xe1, /* 214: rgb(197,  93,  66) */
    0xcc, 0xe1, /* 215: rgb(197, 117,  99) */
    0xe9, 0xe1, /* 216: rgb(197, 125,  74) */
    0x0a, 0xe2, /* 217: rgb(197, 134,  82) */
    0x4f, 0x62, /* 218: rgb(197, 146, 123) */
    0x00, 0x64, /* 219: rgb(206,   0,   0) */
    0x27, 0xe5, /* 220: rgb(206,  77,  58) */
    0x46, 0x65, /* 221: rgb(206,  81,  49) */
    0x46, 0xe5, /* 222: rgb(206,  85,  49) */
    0x66, 0x65, /* 223: rgb(206,  89,  49) */
    0x87, 0x65, /* 224: rgb(206,  97,  58) */
    0xa9, 0xe5, /* 225: rgb(206, 109,  74) */
    0x0a, 0xe6, /* 226: rgb(206, 134,  82) */
    0xb3, 0x66, /* 227: rgb(206, 170, 156) */
    0xd4, 0x66, /* 228: rgb(206, 178, 165) */
    0x66, 0xe9, /* 229: rgb(214,  93,  49) */
    0x86, 0xe9, /* 230: rgb(214, 101,  49) */
    0x88, 0xe9, /* 231: rgb(214, 101,  66) */
    0x0b, 0xea, /* 232: rgb(214, 134,  90) */
    0x2b, 0xea, /* 233: rgb(214, 142,  90) */
    0xf5, 0x6a, /* 234: rgb(214, 186, 173) */
    0x16, 0xeb, /* 235: rgb(214, 198, 181) */
    0x66, 0x6d, /* 236: rgb(222,  89,  49) */
    0xc8, 0x6d, /* 237: rgb(222, 113,  66) */
    0x4c, 0x6e, /* 238: rgb(222, 146,  99) */
    0x4d, 0xee, /* 239: rgb(222, 150, 107) */
    0x71, 0xee, /* 240: rgb(222, 158, 140) */
    0x16, 0xef, /* 241: rgb(222, 198, 181) */
    0x58, 0x6f, /* 242: rgb(222, 210, 197) */
    0x01, 0xf0, /* 243: rgb(230,   4,   8) */
    0xc6, 0x70, /* 244: rgb(230,  49,  49) */
    0xca, 0xf1, /* 245: rgb(230, 117,  82) */
    0x6d, 0xf2, /* 246: rgb(230, 158, 107) */
    0x8e, 0x76, /* 247: rgb(239, 162, 115) */
    0x2f, 0xfa, /* 248: rgb(247, 142, 123) */
    0xaf, 0x7a, /* 249: rgb(247, 170, 123) */
    0xd2, 0xfe, /* 250: rgb(255, 182, 148) */
    0x15, 0x7f, /* 251: rgb(255, 194, 173) */
    0x79, 0x7f, /* 252: rgb(255, 219, 206) */
    0xdb, 0xff, /* 253: rgb(255, 247, 222) */
    0xee, 0xff, /* 254: rgb(255, 255, 115) */
    0xff, 0xff, /* 255: rgb(255, 255, 255) */
};
