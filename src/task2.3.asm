; task2.4.asm - Sum a user-specified range of array elements
; Demonstrates input validation and partial array processing

%include "asm_io.inc"

segment .data
    init_msg        db "Array initialized with values 1-100", 0
    start_prompt    db "Enter start index (0-99): ", 0
    end_prompt      db "Enter end index (0-99): ", 0
    sum_msg         db "Sum of elements from index ", 0
    to_msg          db " to ", 0
    is_msg          db " is: ", 0
    error_start     db "Error: Start index out of range!", 0
    error_end       db "Error: End index out of range!", 0
    error_order     db "Error: Start must be <= End!", 0

segment .bss
    array       resd 100    ; Array of 100 integers
    start_idx   resd 1      ; User's start index
    end_idx     resd 1      ; User's end index

segment .text
    global asm_main
    
asm_main:
    enter   0,0
    pusha
    
    ; Initialize array with values 1-100
    mov     ecx, 0
init_loop:
    cmp     ecx, 100
    jge     init_done
    mov     eax, ecx
    inc     eax
    mov     [array + ecx*4], eax
    inc     ecx
    jmp     init_loop
    
init_done:
    mov     eax, init_msg
    call    print_string
    call    print_nl
    
    ; Get start index
    mov     eax, start_prompt
    call    print_string
    call    read_int
    mov     [start_idx], eax
    
    ; Validate start index (0-99)
    cmp     eax, 0
    jl      error_start_range
    cmp     eax, 99
    jg      error_start_range
    
    ; Get end index
    mov     eax, end_prompt
    call    print_string
    call    read_int
    mov     [end_idx], eax
    
    ; Validate end index (0-99)
    cmp     eax, 0
    jl      error_end_range
    cmp     eax, 99
    jg      error_end_range
    
    ; Validate start <= end
    mov     eax, [start_idx]
    mov     ebx, [end_idx]
    cmp     eax, ebx
    jg      error_ordering
    
    ; Calculate sum from start to end (inclusive)
    mov     ecx, [start_idx]    ; Current index
    mov     ebx, 0              ; Sum accumulator
    
sum_loop:
    mov     eax, [end_idx]
    cmp     ecx, eax
    jg      sum_done            ; Exit when index > end
    
    ; Add array[index] to sum
    mov     eax, [array + ecx*4]
    add     ebx, eax
    
    inc     ecx
    jmp     sum_loop
    
sum_done:
    ; Print result message
    mov     eax, sum_msg
    call    print_string
    mov     eax, [start_idx]
    call    print_int
    
    mov     eax, to_msg
    call    print_string
    mov     eax, [end_idx]
    call    print_int
    
    mov     eax, is_msg
    call    print_string
    mov     eax, ebx            ; Print sum
    call    print_int
    call    print_nl
    jmp     done
    
error_start_range:
    mov     eax, error_start
    call    print_string
    call    print_nl
    jmp     done
    
error_end_range:
    mov     eax, error_end
    call    print_string
    call    print_nl
    jmp     done
    
error_ordering:
    mov     eax, error_order
    call    print_string
    call    print_nl
    
done:
    popa
    mov     eax, 0
    leave
    ret