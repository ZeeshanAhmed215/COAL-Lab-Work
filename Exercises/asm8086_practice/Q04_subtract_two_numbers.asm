; Q4. Subtract two single-digit numbers (9 - 4)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
msg DB 'Difference = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, msg
    MOV AH, 09h
    INT 21h
    MOV AL, 9
    MOV BL, 4
    SUB AL, BL          ; AL = 5
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
