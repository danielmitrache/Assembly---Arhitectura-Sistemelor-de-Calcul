.data
    n: .space 4
    x: .long 0
    v: .space 400
    i: .space 4
    j: .space 4
    formatRead: .asciz "%ld"
    formatWrite: .asciz "%ld "
    newLine: .asciz "\n"
    msg1: .asciz "Dimensiunea array-ului: "
    msg2: .asciz "Introduceti elementele:\n"
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
    movl $25, %edx
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

sort:

    lea v, %edi
    movl $0, i
    
    ;//for(i = 0; i < n - 1;i ++)
    loop1:
        movl n, %ecx
        decl %ecx
        cmp i, %ecx
        je finish_sort

        ;//for(j = i + 1; j < n; j ++)
        movl i, %ebx
        incl %ebx
        movl %ebx, j

        loop2:
            movl n, %edx
            cmp j, %edx
            je continue

            ;//if(v[j] < v[i])
            ;//   swap(v[i], v[j]);
            movl i, %eax
            movl j, %ebx
            movl (%edi, %eax, 4), %ecx
            movl (%edi, %ebx, 4), %edx

            cmp %ecx, %edx
            jge no_swap

            movl %edx, (%edi, %eax, 4)
            movl %ecx, (%edi, %ebx, 4)

            no_swap:
            
            incl j
            jmp loop2

        continue:

        incl i
        jmp loop1


finish_sort:

    movl $0, i

write_array:
    movl i, %ecx
    cmp %ecx, n
    je close

    movl i, %ecx
    movl (%edi, %ecx, 4), %eax
    pushl %eax
    pushl $formatWrite
    call printf
    popl %ebx
    popl %ebx

    xorl %eax, %eax
    pushl %eax
    call fflush
    popl %ebx

    add $1, i
    jmp write_array

close:
    movl $4, %eax
    movl $1, %ebx
    movl $newLine, %ecx
    movl $2, %edx
    int $0x80
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
    