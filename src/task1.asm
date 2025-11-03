%include "asm_io.inc"
;notes
segment .data
    ;two integers to add
    num1    dd  42          ; First number (42)
    num2    dd  58          ; Second number (58)
    result  dd  0           ; Storage for result
    msg1    db  "The sum is: ", 0

segment .bss
    ; No uninitialized data needed

segment .text
    global asm_main
    
asm_main:
    enter   0,0             ; Setup stack frame
    pusha                   ; Save all registers
    
    ; Print message
    mov     eax, msg1
    call    print_string
    
    ; Load first number into EAX storage
    mov     eax, [num1]     ; EAX = num1 (42)
    
    ; Add second number to EAX storage
    add     eax, [num2]     ; EAX = EAX + num2 (42 + 58 = 100)
    
    ; Store result
    mov     [result], eax   ; result = EAX
    
    ; Print the result
    call    print_int       ; print_int uses value in EAX
    call    print_nl        ; Print newline
    
    popa                    ; Restore all registers
    mov     eax, 0          ; Return 0 (success)
    leave                   ; Cleanup stack frame
    ret                     ; Return to C caller