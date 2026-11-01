; Q10. Greater of two numbers
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
A DB 5
B DB 8
msg DB 'Greater number = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, msg
    MOV AH, 09h
    INT 21h
    MOV AL, A
    CMP AL, B
    JAE SHOW
    MOV AL, B
SHOW:
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
