; Q12. Positive, negative or zero (signed byte; change NUM to test)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
NUM  DB -5
msgP DB 'POSITIVE$'
msgN DB 'NEGATIVE$'
msgZ DB 'ZERO$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV AL, NUM
    CMP AL, 0
    JL  IS_NEG          ; signed compare
    JE  IS_ZERO
    LEA DX, msgP
    JMP SHOW
IS_NEG:
    LEA DX, msgN
    JMP SHOW
IS_ZERO:
    LEA DX, msgZ
SHOW:
    MOV AH, 09h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
