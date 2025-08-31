// Lilly Adventure (1983)
// SPDX-License-Identifier: CC0-1.0
#include "atari2600.h"
#include "gfx.h"

#define VBLANK_TIM64 51 // 45 lines * 76 cycles/line / 64 cycles/tick
#define KERNAL_T1024 17 // 228 lines * 76 cycles/line / 1024 cycles/tick
#define OVERSCAN_TIM64 42 // 36 lines * 76 cycles/line / 64 cycles/tick

void main(void) {
    unsigned char x = 0;
    unsigned char cont = 1;
    unsigned char t = 1;
    unsigned char a = 1;
    for/*ever*/(;;) {
        // Displaying background1

        // Vertical Sync signal
        TIA.vsync = 0x02;
        TIA.wsync = 0x00;
        TIA.wsync = 0x00;
        TIA.wsync = 0x00;
        TIA.vsync = 0x00;

        // Vertical Blank timer setting
        RIOT.tim64t = VBLANK_TIM64;

        // Wait for end of Vertical Blank
        while (RIOT.timint == 0) {}
        TIA.wsync = 0x00;
        TIA.vblank = 0x00; // Turn on beam

        // Display frame
        RIOT.t1024t = KERNAL_T1024;
        while (RIOT.timint == 0) {
        if (cont == 1)
        {
        TIA.colubk = background1[x]; // Update color
        x++;
        }
        else {
            TIA.colubk = 0x00;
        }
        if (x == sizeof(background1)) {
            x = 0;
            // cont = 0;
        }
        }
        TIA.wsync = 0x00;
        TIA.vblank = 0x02; // Turn off beam

        // Overscan
        RIOT.tim64t = OVERSCAN_TIM64;
        while (RIOT.timint == 0) {}

        cont = 1;

        // add sound
        TIA.audc0 = 0x01;
        if (cont == 1)
        {
        TIA.audf0 = background2[t];
        TIA.audv0 = background3[a];
        }
        // TIA.audv0 = 0x0F;

        if (t == sizeof(background2)) {
            t = 0;
        }

        t++;

        if (a == sizeof(background2)) {
            a = 0;
        }

        a++;
    }
}