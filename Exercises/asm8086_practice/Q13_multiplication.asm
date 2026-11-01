; Q13. Multiply two unsigned numbers using MUL (6 x 7)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
msg DB 'Product = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV AL, 6
    MOV BL, 7
    MUL BL              ; AX = AL * BL = 42
    PUSH AX
    LEA DX, msg
    CALL PRINT_STR
    POP AX
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
END MAIN
