; Q9. Check even or odd (change NUM to test)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
NUM  DB 7
msgE DB 'Number is EVEN$'
msgO DB 'Number is ODD$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV AL, NUM
    TEST AL, 1          ; test lowest bit
    JZ IS_EVEN
    LEA DX, msgO
    JMP SHOW
IS_EVEN:
    LEA DX, msgE
SHOW:
    MOV AH, 09h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
