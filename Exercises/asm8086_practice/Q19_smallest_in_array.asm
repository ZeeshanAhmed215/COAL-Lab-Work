; Q19. Smallest element in an array of five unsigned bytes
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
arr DB 12, 45, 7, 89, 23
msg DB 'Smallest = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA SI, arr
    MOV AL, [SI]        ; assume first is smallest
    MOV CX, 4
NEXT:
    INC SI
    CMP AL, [SI]
    JBE KEEP
    MOV AL, [SI]
KEEP:
    LOOP NEXT
    PUSH AX
    LEA DX, msg
    CALL PRINT_STR
    POP AX
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
END MAIN
