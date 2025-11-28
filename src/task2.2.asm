; task2.3.asm - Initialize array with 1-100 and calculate sum
; Demonstrates array manipulation and accumulation

%include "asm_io.inc"

segment .data
    init_msg    db "Initializing array with values 1-100...", 0
    sum_msg     db "Sum of array: ", 0

segment .bss
    array   resd 100        ; Array of 100 words (integers)

segment .text
    global asm_main
    
asm_main:
    enter   0,0
    pusha
    
    ; Print initialization message
    mov     eax, init_msg
    call    print_string
    call    print_nl
    
    ; Initialize array with values 1-100
    mov     ecx, 0          ; Array index (0-99)
    
init_loop:
    cmp     ecx, 100
    jge     init_done       ; Exit when index >= 100
    
    ; Calculate value (index + 1) and store in array
    mov     eax, ecx
    inc     eax             ; EAX = index + 1 (gives us 1-100)
    mov     [array + ecx*4], eax  ; Store in array[index]
                                  ; ecx*4 because each dword is 4 bytes
    
    inc     ecx             ; Next index
    jmp     init_loop
    
init_done:
    ; Now sum the array
    mov     ecx, 0          ; Index counter
    mov     ebx, 0          ; Sum accumulator
    
sum_loop:
    cmp     ecx, 100
    jge     sum_done        ; Exit when index >= 100
    
    ; Add array[index] to sum
    mov     eax, [array + ecx*4]
    add     ebx, eax        ; sum += array[index]
    
    inc     ecx             ; Next index
    jmp     sum_loop
    
sum_done:
    ; Print result
    mov     eax, sum_msg
    call    print_string
    mov     eax, ebx        ; Move sum to EAX for printing
    call    print_int
    call    print_nl
    
    popa
    mov     eax, 0
    leave
    ret