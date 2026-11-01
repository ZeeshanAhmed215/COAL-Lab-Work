; Q21. Count even and odd numbers in an array of ten unsigned bytes
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
arr  DB 3, 8, 15, 22, 7, 10, 41, 6, 9, 12
msgE DB 'Even count = $'
msgO DB 'Odd count  = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA SI, arr
    MOV CX, 10
    XOR BX, BX          ; BL = even count, BH = odd count
COUNT_LOOP:
    MOV AL, [SI]
    TEST AL, 1
    JZ  EVEN_NUM
    INC BH
    JMP NEXT
EVEN_NUM:
    INC BL
NEXT:
    INC SI
    LOOP COUNT_LOOP
    LEA DX, msgE
    CALL PRINT_STR
    MOV AL, BL
    XOR AH, AH
    CALL PRINT_NUM
    CALL PRINT_NL
    LEA DX, msgO
    CALL PRINT_STR
    MOV AL, BH
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
