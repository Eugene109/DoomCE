#include "textures.h"
#include <fileioc.h>

#define textures_HEADER_SIZE 0

unsigned char *textures_appvar[3] =
{
    (unsigned char*)0,
    (unsigned char*)8194,
    (unsigned char*)16388,
};

unsigned char textures_init(void)
{
    unsigned int data, i;
    uint8_t appvar;

    appvar = ti_Open("textures", "r");
    if (appvar == 0)
    {
        return 0;
    }

    data = (unsigned int)ti_GetDataPtr(appvar) - (unsigned int)textures_appvar[0] + textures_HEADER_SIZE;
    for (i = 0; i < 3; i++)
    {
        textures_appvar[i] += data;
    }

    ti_Close(appvar);

    return 1;
}

