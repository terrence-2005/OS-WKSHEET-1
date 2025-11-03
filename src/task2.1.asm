; task2_1.asm
; Asks for a name and a number (51-99), then
; prints a welcome message that many times.
; This file includes a custom 'read_string' loop.

%include "asm_io.inc"

; Define 'ENTER_KEY' for readability, its value is 10 (Newline)
%define ENTER_KEY 10

segment .data
    msg_name    db  "Enter your name: ", 0
    msg_num     db  "Enter a number (51-99): ", 0
    msg_welcome db  "Welcome, ", 0
    msg_error   db  "Error: The number is outside the valid range.", 0

segment .bss
    ; Reserve 50 bytes for the user's name
    user_name   resb 50

segment .text
    global asm_main
asm_main:
    pusha

    ; --- Part 1: Ask for and read the name ---
    mov     eax, msg_name
    call    print_string

    ; Custom string-reading loop
    mov     edi, user_name  ; EDI will be our pointer to the name buffer

.read_name_loop:
    call    read_char       ; Read a single character into EAX
    cmp     eax, ENTER_KEY  ; Compare the character to 'Enter'
    je      .read_name_done ; If 'Enter', we're done
    
    mov     [edi], al       ; Store the 8-bit char (AL) into the buffer
    inc     edi             ; Move the buffer pointer to the next byte
    jmp     .read_name_loop ; Repeat the loop

.read_name_done:
    mov     byte [edi], 0   ; Add the null terminator (0) to end the string

    ; --- Part 2: Ask for and read the number ---
    mov     eax, msg_num
    call    print_string
    call    read_int
    ; The user's number is now in EAX

    ; --- Part 3: Validate the number (Conditionals) ---
    ; Check for "greater than 50" [cite: 82-84, 1416-1419]
    cmp     eax, 50
    jle     .error          ; Jump if Less or Equal (<= 50)
    
    ; Check for "less than 100" [cite: 82-84]
    cmp     eax, 100
    jge     .error          ; Jump if Greater or Equal (>= 100)

    ; If we are here, the number is valid (51-99).
    mov     ecx, eax        ; Move the valid count into ECX for the loop
    jmp     .welcome_loop   ; Skip the error message

.error:
    mov     eax, msg_error
    call    print_string
    call    print_nl
    jmp     .done           ; Skip the welcome loop

    ; --- Part 4: Print the welcome message (Loop) ---
.welcome_loop:
    mov     eax, msg_welcome ; Print "Welcome, "
    call    print_string
    mov     eax, user_name   ; Print the name we read
    call    print_string
    call    print_nl
    
    ; The 'loop' instruction auto-decrements ECX
    ; and jumps to the label if ECX > 0 [cite: 1599-1601]
    loop    .welcome_loop

.done:
    popa
    mov     eax, 0
    ret
