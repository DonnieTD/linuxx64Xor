; nasm -f elf64 solution64.s
; ld -o solution64 solution64.o

global start

KEY equ 2 

BUFFERSIZE equ 256 

section .data
    promptMsg db "Input String: ",0
    encryptedMsg db "Encrypted: ",0
    newline db 10, 0

section .bss
    buffer resb BUFFERSIZE
    bufSize resd 1

section .text
start:
    call GetString ; input the plain text
    call EncryptBffer ; encrypt the buffer
    mov rdx, encryptedMsg ; display encrypted message
    call PrintString
  
    mov rax, 1
    xor rbx, rbx
    int 80h


GetString:
    mov rdx, promptMsg 
    call WriteString
    mov rcx, BUFFERSIZE 
    mov rdx, buffer 
    call ReadString 
    mov [bufSize], rax 
    call WriteNewLine
    ret


PrintString:
    call WriteString
    mov rdx, buffer 
    call WriteString
    call WriteNewLine
    call WriteNewLine
    ret

EncryptBffer:
    mov rcx, [bufSize] 
    mov rsi,0 
innerLoop:
    xor byte [buffer + rsi],KEY 

    inc rsi 
    loop innerLoop
    ret

WriteString:

    mov rcx, rdx
    xor rdx, rdx
.stringLen:
    cmp byte [rcx + rdx], 0
    jz .finally
    inc rdx
    jmp .stringLen
.finally:
    mov rbx, 1
    mov rax, 4
    int 80h
    ret

ReadString:
    xchg rcx, rdx
    mov rbx, 1
    mov rax, 3
    int 80h
    mov byte [rcx + rax + 1], 0
    ret

WriteNewLine:
    mov rdx, newline
    call WriteString
    ret
 