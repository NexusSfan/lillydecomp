// Lilly Adventure (1983)
// SPDX-License-Identifier: CC0-1.0
#include "game.h"

// The main code starts here with remapped TIA registers:

void main(void)
{
    byte bVar1;
    ushort uVar2;
    undefined1 uVar3;
    byte bVar4;
    char cVar5;
    char cVar6;
    byte bVar7;
    bool bVar8;

    do {
        cVar5 = 6;
        do {
            cVar5 = cVar5 + -1;
        } while (-1 < cVar5);

        bVar7 = 0x14;
        do {
            cVar5 = 2;
            do {
                cVar5 = cVar5 + -1;
            } while (-1 < cVar5);
            
            DAT_008e = *(undefined1 *)(DAT_0095 + (ushort)bVar7);

            bVar7 = bVar7 - 1;
        } while (-1 < (char)bVar7);

        // TIA Register Writes
        TIA.resp0 = 0x32; // DAT_0010 = 0x32;
        TIA.enam1 = 0x10; // DAT_0020 = 0x10;
        TIA.hmp0  = 0xf0; // DAT_0022 = 0xf0;
        TIA.hmp1  = 0xf0; // DAT_0023 = 0xf0;

        cVar5 = 0x0e;
        while (cVar5 = cVar5 + -1, -1 < cVar5) {
            *(char *)(DAT_008a - 0x1000) = *(char *)(DAT_008a - 0x1000) << 1;
        }

        TIA.grp0    = 0; // DAT_001d = 0;
        TIA.colupf  = DAT_0088; // DAT_0006 = DAT_0088;
        TIA.resp1   = 0; // DAT_0011 = 0;
        TIA.colubk  = DAT_0089; // DAT_0007 = DAT_0089;
        TIA.enabl   = 0x10; // DAT_0021 = 0x10;

        bVar7 = 6;
        do {
            TIA.refp1 = 0x34; // DAT_000a = 0x34;
            uVar2 = (ushort)bVar7;
            bVar7 = bVar7 - 1;
        } while (-1 < (char)bVar7);

        cVar5 = 0x0f;
        do {
            TIA.audv0 = 0; // DAT_001b = 0;
            TIA.audv1 = 0; // DAT_001c = 0;
            cVar5 = cVar5 + -1;
        } while (-1 < cVar5);

        cVar5 = 4;
        do {
            TIA.refp0 = DAT_008d; // DAT_0009 = DAT_008d;
            cVar5 = cVar5 + -1;
        } while (cVar5 != 0);

        TIA.cxclr   = 0xcc; // DAT_002c = 0xcc;
        TIA.ctrlpf  = 0; // DAT_0008 = 0;
        TIA.enam0   = 2; // DAT_001f = 2;
        uVar3 = 2;
        cVar6 = 2;
        cVar5 = 0;

        TIA.colup0  = 0; // DAT_0004 = 0;
        TIA.colup1  = 0; // DAT_0005 = 0;
        TIA.pf2     = 0; // DAT_000d = 0;
        TIA.pf0     = 0; // DAT_000e = 0;
        TIA.pf1     = 0; // DAT_000f = 0;
        TIA.hmclr   = (&UNK_fd27)[uVar2]; // DAT_002b = (&UNK_fd27)[uVar2];

        while( true ) {
            TIA.nusiz0 = uVar3; // DAT_0002 = uVar3;
            TIA.hmove  = uVar3; // DAT_002a = uVar3;

            TIA.nusiz0 = FUN_fb1b(*(undefined1 *)(ushort)(byte)(cVar6 + 0xb7)); // DAT_0002 = FUN_fb1b(...)

            *(byte *)(ushort)(byte)(cVar6 + TIA.enam0) = TIA.nusiz0; // ENAM0 is at 0x1f

            do {
                cVar5 = cVar5 + -1;
            } while (-1 < cVar5);

            *(byte *)(ushort)(byte)(cVar6 + TIA.pf1) = TIA.nusiz0; // PF1 is at 0x0f

            TIA.colubk = DAT_00ee; // DAT_0007 = DAT_00ee;
            TIA.pf0 = DAT_00bf; // DAT_000b = DAT_00bf;
            TIA.refp1 = 0x31; // DAT_000a = 0x31;
            TIA.hmove = TIA.nusiz0; // DAT_002a = DAT_0002;

            uVar3 = FUN_fb35();
            TIA.hmclr = uVar3; // DAT_002b = uVar3;

            cVar6 = cVar6 + -1;
            if (cVar6 == 0) break;
            if (cVar6 == 0) {
                /* WARNING: Bad instruction - Truncating control flow here */
                halt_baddata();
            }
        }
        
        cVar5 = '\0';
        do {
            cVar6 = cVar5;
            if ((-1 < (char)(cVar6 - DAT_00bb)) && (-1 < DAT_00c0)) {
                DAT_00c0 = DAT_00c0 + -1;
            }
            if ((-1 < (char)(cVar6 - DAT_00bd)) && (-1 < (char)DAT_00be)) {
                DAT_00be = DAT_00be - 1;
            }
            cVar5 = cVar6 + '\x01';
        } while ((char)(cVar6 + '\x01') != '(');
        
        if ((-1 < (char)('(' - DAT_00bd)) && (-1 < (char)DAT_00be)) {
            DAT_00be = DAT_00be - 1;
        }
        
        bVar7 = cVar6 + 2;
        cVar5 = DAT_00c4;
        
        if (DAT_00c4 < '\0') {
            if (((char)(bVar7 - DAT_00bd) < '\0') || ((char)DAT_00be < '\0')) {
                // UndefinedFunction_f000 = (code)((char)UndefinedFunction_f000 << 2);
            }
            else {
                *(char *)(bVar7 - 0x1000) = *(char *)(bVar7 - 0x1000) << 1;
                DAT_00be = DAT_00be - 1;
                cVar5 = DAT_00c4;
            }
            do {
                cVar5 = cVar5 + '\x01';
            } while (cVar5 < '\0');
        }
        else {
            do {
                cVar5 = cVar5 + -1;
            } while (-1 < cVar5);
            
            if ((-1 < (char)(bVar7 - DAT_00bd)) && (-1 < (char)DAT_00be)) {
                DAT_00be = DAT_00be - 1;
            }
        }
        
        bVar7 = cVar6 + 3;
        TIA.enam0 = 0; // DAT_001f = 0;
        
        if ((-1 < (char)(bVar7 - DAT_00bd)) && (-1 < (char)DAT_00be)) {
            DAT_00be = DAT_00be - 1;
        }
        
        TIA.ctrlpf = 0x24; // DAT_0008 = 0x24;
        
        do {
            if (((char)(bVar7 - DAT_00bd) < '\0') || ((char)DAT_00be < '\0')) {
                // UndefinedFunction_f000 = (code)((char)UndefinedFunction_f000 << 1);
            }
            else {
                DAT_00be = DAT_00be - 1;
            }
            bVar7 = bVar7 + 1;
            bVar8 = 0x35 < bVar7;
        } while (bVar7 != 0x36);
        
        TIA.pf2 = 0xf0; // DAT_000d = 0xf0;
        cVar5 = '6';
        
        do {
            cVar6 = cVar5;
            bVar7 = (byte)((cVar6 + -0x36) - !bVar8) >> 2;
            TIA.pf0 = *(undefined1 *)(DAT_00a7 + (ushort)bVar7); // DAT_000e = *(...)
            TIA.pf1 = *(undefined1 *)(DAT_00a9 + (ushort)bVar7); // DAT_000f = *(...)
            
            if (((char)(cVar6 - DAT_00bd) < '\0') || ((char)DAT_00be < '\0')) {
                // UndefinedFunction_f000 = (code)((char)UndefinedFunction_f000 << 1);
            }
            else {
                DAT_00be = DAT_00be - 1;
            }
            bVar8 = true;
            cVar5 = cVar6 + '\x01';
        } while ((char)(cVar6 + '\x01') != 'J');
        
        cVar5 = DAT_00c3;
        if (DAT_00c3 < '\0') {
            TIA.resp1 = 0; // DAT_0011 = 0;
            
            if (((char)('J' - DAT_00bd) < '\0') || ((char)DAT_00be < '\0')) {
                // UndefinedFunction_f000 = (code)((char)UndefinedFunction_f000 << 1);
                /* WARNING (jumptable): Read-only address (RAM,0xf04a) is written */
            }
            else {
                /* WARNING (jumptable): Read-only address (RAM,0xf04a) is written */
                TIA.resp1 = *(undefined1 *)(DAT_00a5 + (ushort)DAT_00be); // DAT_0011 = *(...)
                DAT_00be = DAT_00be - 1;
            }
            
            // uRAMf04a = 10;
            
            do {
                cVar5 = cVar5 + '\x01';
            } while (cVar5 < '\0');
        }
        else {
            do {
                cVar5 = cVar5 + -1;
            } while (-1 < cVar5);
            
            TIA.resp1 = 0; // DAT_0011 = 0;
            
            if ((-1 < (char)('J' - DAT_00bd)) && (-1 < (char)DAT_00be)) {
                DAT_00be = DAT_00be - 1;
            }
        }
        
        DAT_008f = 0;
        if ((-1 < (char)((cVar6 + '\x02') - DAT_00bd)) && (-1 < (char)DAT_00be)) {
            DAT_008f = *(byte *)(DAT_00a5 + (ushort)DAT_00be);
            DAT_00be = DAT_00be - 1;
        }
        
        cVar6 = cVar6 + '\x03';
        TIA.colup1 = DAT_00c5; // DAT_0005 = DAT_00c5;
        TIA.enabl = DAT_00c5; // DAT_0021 = DAT_00c5;
        TIA.colubk = 0x3a; // DAT_0007 = 0x3a;
        DAT_008e = 0;
        bVar7 = DAT_00be;
        
        do {
            TIA.nusiz0 = (&DAT_fd00)[bVar7]; // DAT_0002 = (&DAT_fd00)[bVar7];
            TIA.audv0 = DAT_008f; // DAT_001b = DAT_008f;
            TIA.audv1 = *(undefined1 *)(DAT_00a3 + (ushort)DAT_008e); // DAT_001c = *(...)
            DAT_008e = DAT_008e + 1;
            TIA.hmclr = 0; // DAT_002b = 0;
            bVar7 = DAT_008e;
            
            if ((-1 < (char)(cVar6 - DAT_00bd)) && (bVar7 = DAT_00be, -1 < (char)DAT_00be)) {
                TIA.hmclr = *(byte *)(DAT_00a5 + (ushort)DAT_00be); // DAT_002b = *(...)
                bVar7 = DAT_00be - 1;
                DAT_00be = bVar7;
            }
            cVar6 = cVar6 + '\x01';
            DAT_008f = TIA.hmclr;
        } while (cVar6 != 'U');
        
        TIA.colupf = TIA.nusiz0; // DAT_0006 = DAT_0002;
        TIA.hmove = TIA.nusiz0; // DAT_002a = DAT_0002;

        FUN_fa1f(3, 0xa3);
        FUN_fb44();
        FUN_fa1f(6, 0xa3);

        DAT_00af._0_1_ = 0xe3;
        DAT_00b1._0_1_ = 0xe3;
        
        FUN_fb44();
        RIOT.tstrt = 0x3a; // DAT_0296 = 0x3a;
        
        if ((DAT_00d1 != '\0') && ((DAT_00c7 & 0x80) != 0x80)) {
            if ((DAT_00e8 & 7) == 0) {
                bVar7 = DAT_00cd - 1;
                DAT_00cc = DAT_00cc - ((bVar7 & ~DAT_00cd & 0x80) == 0);
                DAT_00cd = bVar7;
                if ((DAT_00cc != '\0') || (bVar7 != 0)) goto LAB_f42e;
            LAB_f446:
                DAT_00d2 = 0xf;
            }
            else {
            LAB_f42e:
                if ((TIA.colubk & 0x80) == 0x80) { // DAT_0007 & 0x80
                LAB_f43a:
                    if ((0x35 < DAT_00bd) && ((char)DAT_00a3 != '@')) goto LAB_f450;
                    goto LAB_f446;
                }
                if (DAT_00bd < 0x48) goto LAB_f450;
                if (DAT_00bd < 0x48) goto LAB_f43a;
            }
            DAT_00c7 = DAT_00c7 | 0x80;
        }
    LAB_f450:
        if ((DAT_00c7 & 0x40) == 0x40) {
            if ((DAT_00c8 < 0x1c) && ((TIA.nusiz0 & 0x80) != 0x80)) { // DAT_0002 & 0x80
                if (DAT_00c8 < 0xc) {
                LAB_f507:
                    DAT_00bd = DAT_00bd - 4;
                    DAT_00c8 = DAT_00c8 + 4;
                    if (DAT_00c8 == 0) goto LAB_f517;
                }
                else if ((DAT_00e8 & 1) == 0) {
                    DAT_00bd = DAT_00bd - 1;
                    DAT_00c8 = DAT_00c8 + 1;
                    if (DAT_00c8 == 0) goto LAB_f507;
                }
            }
            else {
            LAB_f517:
                DAT_00c7 = DAT_00c7 & 0xbf;
            }
        }
        else {
            if (DAT_00bd < 0x80) {
                if ((((TIA.nusiz0 & 0x80) != 0x80) || (0x28 < DAT_00bd)) && // DAT_0002 & 0x80
                    (((DAT_00c7 & 0x80) == 0x80 || (((TIA.colubk & 0x80) != 0x80 || (DAT_00bd < 0x36)))))) { // DAT_0007 & 0x80
                    if ((DAT_00e8 & 1) == 0) {
                        DAT_00bd = DAT_00bd + 1;
                    }
                    goto LAB_f51d;
                }
                if ((DAT_00c7 & 0x80) == 0x80) {
                    if (DAT_00d2 != 0) goto LAB_f51d;
                    if (DAT_00d2 == 0) goto LAB_f45d;
                }
            }
            else {
            LAB_f45d:
                DAT_00bd = 0x28;
                DAT_00b8 = 8;
                DAT_00c7 = DAT_00c7 & 0x7f;
                if ((DAT_00d1 != '\0') &&
                    (((RIOT.SWCHB & 0x80) != 0x80 || (DAT_00d1 = DAT_00d1 + -1, DAT_00d1 != '\0')))) {
                    DAT_00cc = 0x10;
                    DAT_00cd = 0;
                }
                if ((DAT_00d4 & 1) != 0) {
                    DAT_00c2 = 0x50;
                }
            }
            if (DAT_00d1 != '\0') {
                if ((TIA.pf1 & 0x80) == 0x80) { // DAT_000c & 0x80
                    DAT_00c7 = DAT_00c7 & 0xdf;
                    DAT_00c8 = 0;
                }
                else if ((DAT_00c7 & 0x20) == 0) {
                    DAT_00c7 = DAT_00c7 | 0x60;
                    DAT_00bd = DAT_00bd - 4;
                    DAT_00d2 = 8;
                }
            }
        }
    LAB_f51d:
        if ((DAT_00d1 != '\0') && (((TIA.nusiz0 & 0x80) != 0x80 || (DAT_00bd < 0x29)))) { // DAT_0002 & 0x80
            if ((DAT_0280 & 0x80) == 0x80) {
                if ((DAT_0280 & 0x40) != 0x40) {
                    if ((8 < DAT_00b8) && ((DAT_00e8 & 3) == 0)) {
                        DAT_00b8 = DAT_00b8 - 1;
                    }
                    DAT_00bf = 8;
                }
            }
            else if ((DAT_00c7 & 0x80) != 0x80) {
                if (DAT_00b8 < 0x9f) {
                    if ((DAT_00e8 & 3) == 0) {
                        DAT_00b8 = DAT_00b8 + 1;
                        if (DAT_00b8 != 0) goto LAB_f590;
                        goto LAB_f558;
                    }
                }
                else {
                LAB_f558:
                    DAT_00b8 = 8;
                    bVar7 = 2;
                    bVar8 = false;
                    do {
                        DAT_00cd = bVar7;
                        bVar4 = *(byte *)(ushort)(byte)(DAT_00cd - 0x32);
                        bVar1 = *(byte *)(ushort)(byte)(DAT_00cd - 0x35);
                        *(byte *)(ushort)(byte)(DAT_00cd - 0x32) = bVar4 + bVar1 + bVar8;
                        bVar7 = DAT_00cd - 1;
                        bVar8 = CARRY1(bVar4, bVar1);
                    } while (-1 < (char)(DAT_00cd - 1));
                    DAT_00cc = 0x10;
                    DAT_00d1 = DAT_00d1 + 1;
                    DAT_00d3 = DAT_00d3 + 1;
                    DAT_00d5 = DAT_00d5 + 1;
                    DAT_00d4 = DAT_00d5 & 3;
                    FUN_f8d6();
                }
                DAT_00bf = 0;
            }
        }
    LAB_f590:
        bVar7 = DAT_00e8 >> 4 & 1;
        DAT_00a1 = (&DAT_f8ae)[bVar7];
        uVar3 = DAT_00a1;
        
        if ((!(bool)(DAT_00d4 & 1)) && ((DAT_00e9 & 0x80) != 0x80)) {
            uVar3 = 0x60;
        }
        
        DAT_009d = CONCAT11(DAT_009d._1_1_, uVar3);
        
        if ((DAT_00e9 & 0x20) == 0) {
            cVar5 = '(';
        }
        else {
            cVar5 = 0x10;
        }
        
        DAT_009f = CONCAT11(DAT_009f._1_1_, cVar5 + *(char *)(bVar7 - 0xe28));
        DAT_00c6 = '\0';
        
        if ((((DAT_00d4 & 1) == 0) || (DAT_00c6 = (&DAT_f8b0)[DAT_00d4 >> 1 & 1], DAT_00c6 == '\0')) &&
            ((DAT_00e9 & 0x10) == 0)) {
            DAT_009f = CONCAT11(DAT_009f._1_1_, 0x60);
        }
        
        if ((DAT_00e9 & 0x40) == 0x40) {
            cVar5 = 'P';
        }
        else {
            cVar5 = '@';
        }
        
        DAT_00a3 = CONCAT11(DAT_00a3._1_1_, cVar5 + (&DAT_f1da)[DAT_00e8 >> 7]);
        
        if ((DAT_00d4 & 1) == 0) {
            bVar7 = (DAT_00e9 & 0xc) >> 2;
            if (bVar7 < 2) {
                DAT_00c2 = 0x4c;
            }
            else if (bVar7 == 2) {
                DAT_009f = CONCAT11(DAT_009f._1_1_, 0x60);
            }
            else if ((DAT_00ea & 0x40) == 0x40) {
                DAT_00c2 = 0x6c;
            }
            else {
                DAT_00c2 = 0x2c;
            }
        }
        else if (((DAT_00e8 & 3) == 0) &&
            (bVar4 = DAT_00c2 - 1, bVar7 = ~DAT_00c2, DAT_00c2 = bVar4, (bVar4 & bVar7 & 0x80) == 0)
        ) {
            DAT_00c2 = 0x9f;
        }
        
        cVar5 = DAT_00c9;
        if ((DAT_00e8 & 0x3f) == 0) {
            DAT_00ca = DAT_00ca + '\x01';
            if (DAT_00ca == 0x10) {
                DAT_00ca = '\0';
            }
            cVar5 = DAT_00c9 + -3;
            if ((char)(DAT_00c9 + -3) < '\0') {
                cVar5 = DAT_00c9 + 0x1d;
            }
        }
        DAT_00c9 = cVar5;
        
        if ((DAT_00e8 & 1) != 0) {
            bVar4 = DAT_00e8 >> 1 & 1;
            DAT_008e = (&DAT_f8b6)[*(byte *)(ushort)(byte)(bVar4 - 0x37)];
            bVar7 = *(byte *)(ushort)(byte)(bVar4 + 0xb9);
            
            if (((DAT_008e <= bVar7) || ((bVar7 < 0x88 && (bVar7 = bVar7 + 1, bVar7 == 0)))) &&
                (7 < bVar7)) {
                bVar7 = bVar7 - 1;
            }
            *(byte *)(ushort)(byte)(bVar4 + 0xb9) = bVar7;
            
            DAT_008f = (&DAT_f8b2)[bVar4];
            DAT_0090 = (&DAT_f8b4)[bVar4];
            DAT_008e = DAT_008e & 0x1f;
            bVar7 = *(byte *)(ushort)(byte)(bVar4 + 0xbb);
            
            if (((DAT_008e <= bVar7) || ((bVar7 < DAT_008f && (bVar7 = bVar7 + 1, bVar7 == 0)))) &&
                (DAT_0090 <= bVar7)) {
                bVar7 = bVar7 - 1;
            }
            *(byte *)(ushort)(byte)(bVar4 + 0xbb) = bVar7;
        }
        
        if ((DAT_00e8 & 7) == 0) {
            if (0x9e < DAT_00c1) {
                DAT_00c1 = 0xff;
            }
            DAT_00c1 = DAT_00c1 + 1;
        }
        
        if (DAT_00d4 == 2) {
            // TIA register AUDF0 is at 0x18, AUDF1 is at 0x1A
            // DAT_00a7 and DAT_00a9 are memory addresses, not TIA registers, but are assigned the same as AUDFx
            DAT_00a7 = CONCAT11(0xff, (undefined1)DAT_00a7);
            DAT_00a9 = CONCAT11(0xff, (undefined1)DAT_00a9);
            
            if ((DAT_00e8 & 0x1f) == 0) {
                if ((DAT_00e9 & 1) != 0) {
                    FUN_f9d6(0);
                }
                if ((DAT_00e9 & 2) != 0) {
                    FUN_f9d6(1);
                }
            }
            FUN_f9f1(0);
            FUN_f9f1(1);
        }
        else {
            DAT_00a7 = CONCAT11(0xfd, (&DAT_f9b6)[DAT_00d5 >> 2 & 0x1f]);
            DAT_00a9 = CONCAT11(0xfd, (&DAT_f9b6)[DAT_00d5 >> 2 & 0x1f]);
        }
        
        do {
        } while (RIOT.intim != '\0'); // DAT_0284 != '\0'
        
        TIA.wsync = 0x82; // DAT_0001 = 0x82;
        TIA.nusiz0 = 0x82; // DAT_0002 = 0x82;
        TIA.vblank = RIOT.intim; // DAT_0000 = DAT_0284;
        
        DAT_00e8 = DAT_00e8 + 1;
        RIOT.tstrt = 0x20; // DAT_0296 = 0x20;
        
        bVar8 = (bool)(RIOT.swchb & 1); // DAT_0282 & 1
        RIOT.swchb = RIOT.swchb >> 1; // DAT_0282 >> 1
        
        if (!bVar8) {
            FUN_fab7();
            DAT_00d1 = 5;
            DAT_00ed = 5;
        }
        
        uVar3 = 0xea;
        
        if (((DAT_00c7 & 0x80) != 0x80) && (((TIA.colubk & 0x80) == 0x80 || ((TIA.nusiz0 & 0x80) == 0x80))))
        { // DAT_0007 & 0x80, DAT_0002 & 0x80
            uVar3 = (&DAT_f81b)[DAT_00b8 & 1];
        }
        
        DAT_00a5 = CONCAT11(DAT_00a5._1_1_, uVar3);
        
        if (DAT_00d8 == '\0') {
            DAT_00da = DAT_00da - 1;
            if ((char)DAT_00da < '\0') {
                DAT_00d6 = DAT_00d6 - 1;
                if ((char)DAT_00d6 < '\0') {
                    DAT_00d6 = 0x7f;
                }
                DAT_00e5 = (&DAT_fb95)[DAT_00d6 >> 1 & 3];
                DAT_00e6 = (&DAT_fb99)[DAT_00d6 >> 3 & 3];
                DAT_00e7 = (&DAT_fb99)[DAT_00d6 >> 5 & 3];
                DAT_00e0 = CONCAT11(DAT_00e0._1_1_, (&DAT_fbc0)[DAT_00d7]);
                DAT_00da = (&DAT_fbbb)[DAT_00d7];
            }
            
            while (DAT_008e = *(byte *)(DAT_00e0 + (ushort)DAT_00da), (DAT_008e & 0xf0) == 0xf0) {
                DAT_00e4 = DAT_008e & 0xf;
                DAT_00d9 = '\0';
                DAT_00db = '\0';
                DAT_00da = DAT_00da - 1;
            }
            DAT_00d8 = (&DAT_fb9d)[DAT_008e & 0xf];
            DAT_00de = 0xf;
        }
        
        DAT_00d8 = DAT_00d8 + -1;
        TIA.audc0 = DAT_00e5; // DAT_0015 = DAT_00e5;
        
        FUN_fafd(*(undefined1 *)(DAT_00e0 + (ushort)DAT_00da), 0);
        
        if (DAT_00d9 == '\0') {
            DAT_00db = DAT_00db + -1;
            if (DAT_00db < '\0') {
                DAT_00db = (&UNK_fbc5)[DAT_00d6 & 1];
            }
            bVar7 = FUN_fade();
            DAT_00d9 = (&DAT_fb9d)[bVar7 & 0xf];
            DAT_00df = 10;
        }
        
        DAT_00d9 = DAT_00d9 + -1;
        
        if (DAT_00d2 == 0) {
            TIA.audc1 = DAT_00e5; // DAT_0016 = DAT_00e5;
            FUN_fade(DAT_00db);
            FUN_fafd(1, 0); // Assuming two parameters for fafd
        }
        
        if (DAT_00d2 == 0) {
            if ((DAT_00bd + 0xb4 & ~DAT_00bd & 0x80) != 0) {
                TIA.audf0 = (&DAT_f8b6)[DAT_00e8]; // DAT_0018 = (&DAT_f8b6)[DAT_00e8];
                TIA.audf1 = (byte)(DAT_00bd + 0xb4) >> 2 ^ 0xf; // DAT_001a = (...)
                TIA.audc1 = 0xc; // DAT_0016 = 0xc;
            }
        }
        else {
            if ((DAT_00c7 & 0x80) == 0x80) {
                TIA.audc1 = 3; // DAT_0016 = 3;
                TIA.audf0 = 0x1f; // DAT_0018 = 0x1f;
            LAB_f7f4:
                DAT_00d2 = DAT_00d2 - 1;
                if (DAT_00d2 == 0) {
                    TIA.audf1 = 0; // DAT_001a = 0;
                    goto LAB_f1ec;
                }
            }
            else {
                TIA.audf0 = (&UNK_f81d)[DAT_00d2]; // DAT_0018 = (&UNK_f81d)[DAT_00d2];
                TIA.audc1 = 4; // DAT_0016 = 4;
                if ((DAT_00e8 & 3) == 0) goto LAB_f7f4;
            }
            TIA.audf1 = 0xf; // DAT_001a = 0xf;
        }
    LAB_f1ec:
        FUN_f88a();
        FUN_fb1b(1, 4); // Assuming FUN_fb1b can take two parameters
        FUN_fb3a();
        
        DAT_00be = 0xf;
        DAT_00c0 = 7;
        
        FUN_fb1b(0x6d, 2); // Assuming FUN_fb1b can take two parameters
        FUN_fb3a();
        FUN_f87c();
        
        do {
        } while (RIOT.intim != '\0'); // DAT_0284 != '\0'
        
        FUN_fa1f(0, (ushort)DAT_0080);
        RIOT.tstrt = 5; // DAT_0296 = 5;
        FUN_f87c();
        
        if ((DAT_00ed & 0x80) == 0x80) {
            cVar6 = 0xc;
            cVar5 = 'P';
            do {
                *(char *)(ushort)(byte)(cVar6 + 0xa9) = cVar5;
                cVar5 = cVar5 + '\b';
                cVar6 = cVar6 + -2;
            } while (cVar6 != '\0');
        }
        
        do {
        } while (RIOT.intim != '\0'); // DAT_0284 != '\0'
        
        TIA.hmove = RIOT.intim; // DAT_002a = DAT_0284;
        TIA.wsync = RIOT.intim; // DAT_0001 = DAT_0284;
        TIA.nusiz0 = RIOT.intim; // DAT_0002 = DAT_0284;
        
        FUN_fb44();
        cVar5 = 0x18;
        do {
            cVar5 = cVar5 + -1;
        } while (-1 < cVar5);
    } while( true );
}
