.data
    n: .space 4
    x: .long 0
    v: .space 400
    i: .space 4
    st: .space 4
    dr: .space 4
    mid: .space 4
    index: .long -1
    formatRead: .asciz "%ld"
    formatWrite: .asciz "%ld "
    newLine: .asciz "\n"
    msg1: .asciz "Dimensiunea array-ului: "
    msg2: .asciz "Introduceti elementele in ordine crescatoare:\n"
    msg3: .asciz "Numarul cautat: "
    msg4: .asciz "Nu exista!\n"
.text
.global main
main:
    movl $4, %eax
    movl $1, %ebx
    movl $msg1, %ecx
    movl $25, %edx
    int $0x80

    pushl $n
    pushl $formatRead
    call scanf
    popl %ebx
    popl %ebx

    movl $4, %eax
    movl $1, %ebx
    movl $msg2, %ecx
    movl $47, %edx
    int $0x80

    movl $0, i
    lea v, %edi

read_array:
    movl i, %ecx
    cmp %ecx, n
    je finish_reading

    pushl $x
    pushl $formatRead
    call scanf
    popl %ebx
    popl %ebx

    movl x, %eax
    movl i, %ecx
    movl %eax, (%edi, %ecx, 4)

    add $1, i
    jmp read_array

finish_reading:

read_target:
    movl $4, %eax
    movl $1, %ebx
    movl $msg3, %ecx
    movl $17, %edx
    int $0x80

    pushl $x
    pushl $formatRead
    call scanf
    popl %ebx
    popl %ebx

    movl $0, st
    movl n, %ebx
    decl %ebx
    movl %ebx, dr

    lea v, %edi

bsearch:
    movl st, %ecx
    cmp %ecx, dr
    jl finish_bsearch

    addl dr, %ecx
    shr %ecx
    movl %ecx, mid

    movl (%edi, %ecx, 4), %ebx
    cmp x, %ebx
    je even
    jg greater
    jl lower

    even:
        movl %ecx, index
        jmp finish_bsearch

    greater:
        decl %ecx
        movl %ecx, dr
        jmp continue

    lower:
        incl %ecx
        movl %ecx, st
        jmp continue

    continue:

    jmp bsearch

finish_bsearch:

    movl $-1, %eax
    cmp %eax, index
    je nu_exista

    pushl index
    pushl $formatWrite
    call printf
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

    jmp close

nu_exista:
    movl $4, %eax
    movl $1, %ebx
    movl $msg4, %ecx
    movl $12, %edx
    int $0x80
    jmp close

close:
    movl $4, %eax
    movl $1, %ebx
    movl $newLine, %ecx
    movl $2, %edx
    int $0x80
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
    