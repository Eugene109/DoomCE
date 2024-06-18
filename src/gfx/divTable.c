#include "div_table_255.h"
#include <fileioc.h>

#define divTable_HEADER_SIZE 0

unsigned char *divTable_appvar[1] =
{
    (unsigned char*)0,
};

unsigned char divTable_init(void)
{
    unsigned int data, i;
    uint8_t appvar;

    appvar = ti_Open("divTable", "r");
    if (appvar == 0)
    {
        return 0;
    }

    data = (unsigned int)ti_GetDataPtr(appvar) - (unsigned int)divTable_appvar[0] + divTable_HEADER_SIZE;
    for (i = 0; i < 1; i++)
    {
        divTable_appvar[i] += data;
    }

    ti_Close(appvar);

    return 1;
}

