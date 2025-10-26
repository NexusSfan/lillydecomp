# Contributing
## Disassembly
In order to get the disassembled code, you need to have Stella 7.0 installed.
Load the Lilly Adventure ROM (binary sha256: 6431a0ef0586e411304782da34ddc7d10f3d0028daeb95a6181d2860d1c028e3) into Stella. Press "`" and then run "saveDis".
Now you have the disassembled assembly.

## Decompilation
Use [Ghidra] with the [RetroGhidra] plugin (which supports Atari VCS) to decompile the Lilly Adventure ROM into psuedocode.

## Compiling
We are using [dasm] to compile the code.

## Documentation
After documenting variables/functions to `asm/LILLY.asm` (main decomp file), run `python tools/doccheck.py asm/LILLY.asm` and put the output in your PR.

## License
All contributions will be licensed under the Creative Commons [CC0] License.

[dasm]: https://dasm-assembler.github.io/
[Ghidra]: https://ghidra-sre.org
[RetroGhidra]: https://github.com/hippietrail/RetroGhidra
[CC0]: https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt

<!--
SPDX-License-Identifier: CC0-1.0
-->