; Q5. Increment a number using INC (5 -> 6)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
msg DB 'After INC = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV BL, 5
    INC BL              ; BL = 6
    LEA DX, msg
    MOV AH, 09h
    INT 21h
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 02h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
