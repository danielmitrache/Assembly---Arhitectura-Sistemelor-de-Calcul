.data
    str: .space 50
    rev: .space 50
    len: .space 4
    newln: .byte 0x0a
.text
.global main
main:
read:
    movl $3, %eax
    movl $1, %ebx
    movl $str, %ecx
    movl $50, %edx
    int $0x80

    xorl %ecx, %ecx
    lea str, %edi
    xorl %eax, %eax
get_len:
    cmp (%edi, %ecx, 1), %eax
    je gasit
    inc %ecx
    jmp get_len

gasit:
    movl %ecx, len

    xorl %ecx, %ecx
    lea str, %esi
    lea rev, %edi
reverse:
    cmp len, %ecx
    je afis

    movl len, %ebx
    sub %ecx, %ebx
    dec %ebx
    xorl %eax, %eax
    movb (%esi, %ecx, 1), %al
    movb %al, (%edi, %ebx, 1)

    inc %ecx
    jmp reverse

afis:
    lea rev, %edi
    movl len, %eax
    movb newln, %bl
    movb %bl, (%edi, %eax, 1)

    inc %eax
    movl %eax, len

    movl $4, %eax
    movl $1, %ebx
    movl $rev, %ecx
    movl len, %edx
    int $0x80

exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
