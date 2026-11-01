; Q14. Divide two unsigned numbers using DIV (47 / 5)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
msgQ DB 'Quotient  = $'
msgR DB 'Remainder = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV AX, 47
    MOV BL, 5
    DIV BL              ; AL = quotient (9), AH = remainder (2)
    MOV CL, AL          ; save quotient
    MOV CH, AH          ; save remainder
    LEA DX, msgQ
    CALL PRINT_STR
    MOV AL, CL
    XOR AH, AH
    CALL PRINT_NUM
    CALL PRINT_NL
    LEA DX, msgR
    CALL PRINT_STR
    MOV AL, CH
    XOR AH, AH
    CALL PRINT_NUM
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; ---- Print '$'-terminated string, address in DX ----
PRINT_STR PROC
    PUSH AX
    MOV AH, 09h
    INT 21h
    POP AX
    RET
PRINT_STR ENDP

; ---- Print unsigned number in AX (decimal) ----
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV BX, 10
    XOR CX, CX
PN_DIV:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    TEST AX, AX
    JNZ PN_DIV
PN_OUT:
    POP DX
    ADD DL, '0'
    MOV AH, 02h
    INT 21h
    LOOP PN_OUT
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

; ---- Print new line ----
PRINT_NL PROC
    PUSH AX
    PUSH DX
    MOV DL, 13
    MOV AH, 02h
    INT 21h
    MOV DL, 10
    INT 21h
    POP DX
    POP AX
    RET
PRINT_NL ENDP
END MAIN
