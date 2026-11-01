; Q8. Add three single-digit numbers (2 + 3 + 4)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
msg DB 'Sum = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, msg
    MOV AH, 09h
    INT 21h
    MOV AL, 2
    ADD AL, 3
    ADD AL, 4           ; AL = 9
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
