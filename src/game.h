// Lilly Adventure (1983)
// SPDX-License-Identifier: CC0-1.0
#ifndef GAME_H
#define GAME_H
#include <stdint.h>
#include <stdbool.h>
#include "atari2600.h"

// Is this used?
// Custom aliases for TIA/RIOT registers that are only read in the loop (assuming memory map)
#define TIA_CXM0P_R  (*(volatile char *)0x30) // Collision Missle 0 / Player (Read)
#define TIA_CXP0FB_R (*(volatile char *)0x32) // Collision Player 0 / Playfield (Read)

// Re-map DAT_00xx variables and functions - retained as is
#define DAT_0080 ((char *)0x80)
#define DAT_0088 (*(volatile char *)0x88)
#define DAT_0089 (*(volatile char *)0x89)
#define DAT_008a (*(volatile char *)0x8a)
#define DAT_008d (*(volatile char *)0x8d)
#define DAT_008e (*(volatile char *)0x8e)
#define DAT_008f (*(volatile char *)0x8f)
#define DAT_0090 (*(volatile char *)0x90)
#define DAT_0095 ((char *)0x95)
#define DAT_009d (*(volatile char *)0x9d)
#define DAT_009f (*(volatile char *)0x9f)
#define DAT_00a1 (*(volatile char *)0xa1)
#define DAT_00a3 (*(volatile char *)0xa3)
#define DAT_00a5 (*(volatile char *)0xa5)
#define DAT_00a7 ((char *)0xa7)
#define DAT_00a9 ((char *)0xa9)
#define DAT_00af (*(volatile unsigned short *)0xaf)
#define DAT_00b1 (*(volatile unsigned short *)0xb1)
#define DAT_00b8 (*(volatile char *)0xb8)
#define DAT_00bb (*(volatile char *)0xbb)
#define DAT_00bd (*(volatile char *)0xbd)
#define DAT_00be (*(volatile char *)0xbe)
#define DAT_00bf (*(volatile char *)0xbf)
#define DAT_00c0 (*(volatile char *)0xc0)
#define DAT_00c1 (*(volatile char *)0xc1)
#define DAT_00c2 (*(volatile char *)0xc2)
#define DAT_00c3 (*(volatile char *)0xc3)
#define DAT_00c4 (*(volatile char *)0xc4)
#define DAT_00c5 (*(volatile char *)0xc5)
#define DAT_00c6 (*(volatile char *)0xc6)
#define DAT_00c7 (*(volatile char *)0xc7)
#define DAT_00c8 (*(volatile char *)0xc8)
#define DAT_00c9 (*(volatile char *)0xc9)
#define DAT_00ca (*(volatile char *)0xca)
#define DAT_00cc (*(volatile char *)0xcc)
#define DAT_00cd (*(volatile char *)0xcd)
#define DAT_00d1 (*(volatile char *)0xd1)
#define DAT_00d2 (*(volatile char *)0xd2)
#define DAT_00d3 (*(volatile char *)0xd3)
#define DAT_00d4 (*(volatile char *)0xd4)
#define DAT_00d5 (*(volatile char *)0xd5)
#define DAT_00d6 (*(volatile char *)0xd6)
#define DAT_00d7 (*(volatile char *)0xd7)
#define DAT_00d8 (*(volatile char *)0xd8)
#define DAT_00d9 (*(volatile char *)0xd9)
#define DAT_00da (*(volatile char *)0xda)
#define DAT_00db (*(volatile char *)0xdb)
#define DAT_00de (*(volatile char *)0xde)
#define DAT_00df (*(volatile char *)0xdf)
#define DAT_00e0 ((char *)0xe0)
#define DAT_00e4 (*(volatile char *)0xe4)
#define DAT_00e5 (*(volatile char *)0xe5)
#define DAT_00e6 (*(volatile char *)0xe6)
#define DAT_00e7 (*(volatile char *)0xe7)
#define DAT_00e8 (*(volatile char *)0xe8)
#define DAT_00e9 (*(volatile char *)0xe9)
#define DAT_00ea (*(volatile char *)0xea)
#define DAT_00ed (*(volatile char *)0xed)
#define DAT_00ee (*(volatile char *)0xee)
#define DAT_0280 (*(volatile char *)0x280) // RIOT I/O Port A (Console Switches, Read)

#define UNK_fd27 ((char *)0xfd27)
#define UNK_fbc5 ((char *)0xfbc5)
#define DAT_fd00 ((char *)0xfd00)
#define DAT_f8ae ((char *)0xf8ae)
#define DAT_f8b0 ((char *)0xf8b0)
#define DAT_f1da ((char *)0xf1da)
#define DAT_f8b6 ((char *)0xf8b6)
#define DAT_f8b2 ((char *)0xf8b2)
#define DAT_f8b4 ((char *)0xf8b4)
#define DAT_f9b6 ((char *)0xf9b6)
#define DAT_f81b ((char *)0xf81b)
#define DAT_fb95 ((char *)0xfb95)
#define DAT_fb99 ((char *)0xfb99)
#define DAT_fbc0 ((char *)0xfbc0)
#define DAT_fbbb ((char *)0xfbbb)
#define DAT_fb9d ((char *)0xfb9d)
#define UNK_f81d ((char *)0xf81d)

// Type redefinitions
typedef char byte;
typedef unsigned short ushort;
typedef char undefined1;

// Function declarations (placeholders)
char FUN_fb1b(char param_1);
char FUN_fb35(void);
void FUN_fa1f(char param_1, ushort param_2);
void FUN_fb44(void);
void FUN_f8d6(void);
void FUN_f9d6(char param_1);
void FUN_f9f1(char param_1);
void FUN_fab7(void);
void FUN_fafd(char param_1, char param_2);
char FUN_fade(char param_1); // Assuming 1 parameter based on usage
char FUN_fade(void); // Assuming 0 parameter based on usage
void FUN_f88a(void);
void FUN_fb3a(void);
void FUN_f87c(void);
void halt_baddata(void);
bool CARRY1(char param_1, char param_2); // Assuming CARRY1 is a macro/function returning bool
char CONCAT11(char param_1, char param_2); // Assuming CONCAT11 combines two bytes into a short (or vice-versa in context)

#endif
