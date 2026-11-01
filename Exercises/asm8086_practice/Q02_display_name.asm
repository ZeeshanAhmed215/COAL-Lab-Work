; Q2. Display name, department, semester (edit the text to your details)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
line1 DB 'Name       : Your Name', 13, 10, '$'
line2 DB 'Department : Computer Science', 13, 10, '$'
line3 DB 'Semester   : 3rd', 13, 10, '$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, line1
    MOV AH, 09h
    INT 21h
    LEA DX, line2
    INT 21h
    LEA DX, line3
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
