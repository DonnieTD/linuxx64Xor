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
    mov edx, encryptedMsg ; display encrypted message
    call PrintString
  
    mov eax, 1
    xor ebx, ebx
    int 80h


GetString:
    pushad
    mov edx, promptMsg 
    call WriteString
    mov ecx, BUFFERSIZE 
    mov edx, buffer 
    call ReadString 
    mov [bufSize], eax 
    call WriteNewLine
    popad
    ret


PrintString:
    pushad
    call WriteString
    mov edx, buffer 
    call WriteString
    call WriteNewLine
    call WriteNewLine
    popad
    ret

EncryptBffer:
    pushad
    mov ecx, [bufSize] 
    mov esi,0 
innerLoop:
    xor byte [buffer + esi],KEY 

    inc esi 
    loop innerLoop
    popad
    ret

WriteString:

    mov ecx, edx
    xor edx, edx
.stringLen:
    cmp byte [ecx + edx], 0
    jz .finally
    inc edx
    jmp .stringLen
.finally:
    mov ebx, 1
    mov eax, 4
    int 80h
    ret

ReadString:
    xchg ecx, edx
    mov ebx, 1
    mov eax, 3
    int 80h
    mov byte [ecx + eax + 1], 0
    ret

WriteNewLine:
    push edx
    mov edx, newline
    call WriteString
    pop edx
    ret
 