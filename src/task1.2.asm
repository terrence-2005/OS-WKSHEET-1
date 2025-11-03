; task1.2.asm
; notes
; Based on slide 22 
;user inputs numbers to sum
%include "asm_io.inc"

segment .data
    msg1 db "Enter a number: ", 0
    msg2 db "The sum of ", 0
    msg3 db " and ", 0
    msg4 db " is: ", 0

segment .bss
    integer1 resd 1
    integer2 resd 1
    result   resd 1

segment .text
    global asm_main
asm_main:
    pusha

    ; Prompt for and read the first integer
    mov     eax, msg1
    call    print_string
    call    read_int
    mov     [integer1], eax

    ; Prompt for and read the second integer
    mov     eax, msg1
    call    print_string
    call    read_int
    mov     [integer2], eax

    ; --- Calculate the sum ---
    mov     eax, [integer1]
    add     eax, [integer2]
    mov     [result], eax

    ; --- Print the full output string ---
    ; "The sum of "
    mov     eax, msg2
    call    print_string

    ; "X" (the first number)
    mov     eax, [integer1]
    call    print_int

    ; " and "
    mov     eax, msg3
    call    print_string

    ; "Y" (the second number)
    mov     eax, [integer2]
    call    print_int

    ; " is: "
    mov     eax, msg4
    call    print_string

    ; "Z" (the result)
    mov     eax, [result]
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    ret