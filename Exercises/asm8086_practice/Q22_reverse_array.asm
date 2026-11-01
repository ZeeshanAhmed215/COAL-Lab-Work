; Q22. Reverse an array of five elements
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
arr DB 1, 2, 3, 4, 5
msgB DB 'Before: $'
msgA DB 'After : $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, msgB
    CALL PRINT_STR
    LEA SI, arr
    CALL PRINT_ARR
    CALL PRINT_NL
    LEA SI, arr         ; SI -> first element
    LEA DI, arr + 4     ; DI -> last element
    MOV CX, 2           ; 5 / 2 swaps
SWAP_LOOP:
    MOV AL, [SI]
    MOV BL, [DI]
    MOV [SI], BL
    MOV [DI], AL
    INC SI
    DEC DI
    LOOP SWAP_LOOP
    LEA DX, msgA
    CALL PRINT_STR
    LEA SI, arr
    CALL PRINT_ARR
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

; ---- Print 5-byte array at SI as numbers separated by spaces ----
PRINT_ARR PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    MOV CX, 5
PA_LOOP:
    MOV AL, [SI]
    XOR AH, AH
    CALL PRINT_NUM
    MOV DL, ' '
    MOV AH, 02h
    INT 21h
    INC SI
    LOOP PA_LOOP
    POP SI
    POP DX
    POP CX
    POP AX
    RET
PRINT_ARR ENDP
END MAIN
