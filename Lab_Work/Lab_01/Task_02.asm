
.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Student Name: Zeeshan Ahmed', 0DH, 0AH, '$'
    MSG2 DB 'Roll Number: 24F-AI-215', '$'

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display student name
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    ; Display roll number
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
