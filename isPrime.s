.data
    ;//Set value to test here
    n: .long 17
    ;//      ^^^
    da: .asciz "E prim!\n"
    nu: .asciz "Nu e prim!\n"
    div2: .long 2
    jumn: .space 4
.text
.global main
main:
    cmp $1, n
    jbe neprim

    xor %edx, %edx
    mov n, %eax
    divl div2
    cmp $0, %edx
    je neprim
    
    mov %eax, jumn
    mov $3, %ecx

et_loop:
    cmp jumn, %ecx
    jge prim

    xor %edx, %edx
    mov n, %eax
    div %ecx
    cmp $0, %edx
    je neprim

    add $2, %ecx
    jmp et_loop

prim:
    movl $4, %eax
    movl $1, %ebx
    mov $da, %ecx
    movl $9, %edx
    int $0x80
    jmp etexit

neprim:
    movl $4, %eax
    movl $1, %ebx
    mov $nu, %ecx
    movl $12, %edx
    int $0x80
    jmp etexit

etexit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80

