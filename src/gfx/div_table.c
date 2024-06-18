#include "div_table_255.h"
#include <fileioc.h>

#define div_table_HEADER_SIZE 0

unsigned char *div_table_appvar[1] =
{
    (unsigned char*)0,
};

unsigned char div_table_init(void)
{
    unsigned int data, i;
    uint8_t appvar;

    appvar = ti_Open("div_table", "r");
    if (appvar == 0)
    {
        return 0;
    }

    data = (unsigned int)ti_GetDataPtr(appvar) - (unsigned int)div_table_appvar[0] + div_table_HEADER_SIZE;
    for (i = 0; i < 1; i++)
    {
        div_table_appvar[i] += data;
    }

    ti_Close(appvar);

    return 1;
}

