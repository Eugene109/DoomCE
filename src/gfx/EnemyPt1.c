#include "zombieman_pt1.h"
#include <fileioc.h>

#define EnemyPt1_HEADER_SIZE 0

unsigned char *EnemyPt1_appvar[12] =
{
    (unsigned char*)0,
    (unsigned char*)4098,
    (unsigned char*)8196,
    (unsigned char*)12294,
    (unsigned char*)16392,
    (unsigned char*)20490,
    (unsigned char*)24588,
    (unsigned char*)28686,
    (unsigned char*)32784,
    (unsigned char*)36882,
    (unsigned char*)40980,
    (unsigned char*)45078,
};

unsigned char EnemyPt1_init(void)
{
    unsigned int data, i;
    uint8_t appvar;

    appvar = ti_Open("EnemyPt1", "r");
    if (appvar == 0)
    {
        return 0;
    }

    data = (unsigned int)ti_GetDataPtr(appvar) - (unsigned int)EnemyPt1_appvar[0] + EnemyPt1_HEADER_SIZE;
    for (i = 0; i < 12; i++)
    {
        EnemyPt1_appvar[i] += data;
    }

    ti_Close(appvar);

    return 1;
}

