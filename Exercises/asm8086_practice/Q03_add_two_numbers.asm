; Q3. Add two single-digit numbers (3 + 5)
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
    MOV AL, 3
    MOV BL, 5
    ADD AL, BL          ; AL = 8
    ADD AL, '0'         ; to ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
