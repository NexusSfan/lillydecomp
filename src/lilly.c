// Lilly Adventure (1983)
#include <vcs.h>
#include <vcs_colors.h>
#include <stdint.h>

// asm: f1e1, f1dc
void Start() {    
    unsigned char x = 0;

    // wait for VSYNC
    do {
        VSYNC = 0;
        RAM_ED = x;
        x++;

    } while (x != 0); // loop continues until x wraps around to 0
}