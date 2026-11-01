; Q15. Print numbers 1 to 10 (1-9 in a loop, 10 handled separately)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
ten DB '10$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV CX, 9
    MOV DL, '1'
PRINT_LOOP:
    MOV AH, 02h
    INT 21h             ; print digit in DL
    PUSH DX
    MOV DL, ' '
    INT 21h
    POP DX
    INC DL
    LOOP PRINT_LOOP
    LEA DX, ten         ; 10 needs two characters
    MOV AH, 09h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
