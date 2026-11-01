; Q20. Sum of an array of five unsigned bytes (16-bit result)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
arr DB 12, 45, 7, 89, 23
msg DB 'Sum = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA SI, arr
    XOR AX, AX
    MOV CX, 5
ADD_LOOP:
    MOV DL, [SI]
    XOR DH, DH
    ADD AX, DX
    INC SI
    LOOP ADD_LOOP       ; AX = 176
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
