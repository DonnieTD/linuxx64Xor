1. Run on linux
2. Download nasm sudo apt-get install nasm
3. compile: nasm -f elf32 solution.s
4. link: ld -o solution solution.o -melf_i386
5. Run: ./solution
6. Enter : String@To3ncrypt
7. Output: QvpkleBVm1lap{rv
8. Run: ./solution
9. Enter : QvpkleBVm1lap{rv
10. Output: String@To3ncrypt

; nasm -f elf32 myfile.asm
; ld -o myfile myfile.o -melf_i386
