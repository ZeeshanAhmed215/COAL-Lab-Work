
.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Minuend: 1234H',13,10,'$'
    MSG2 DB 'Subtrahend: 00F2H',13,10,'$'
    MSG3 DB 'Difference = 1142H',13,10,'$'

    NUM1_LOW  DB 34H
    NUM1_HIGH DB 12H

    NUM2_LOW  DB 0F2H
    NUM2_HIGH DB 00H

    RESULT_LOW  DB ?
    RESULT_HIGH DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display minuend
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    ; Display subtrahend
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    ; Subtract low bytes
    MOV AL, NUM1_LOW
    SUB AL, NUM2_LOW
    MOV RESULT_LOW, AL

    ; Subtract high bytes with borrow
    MOV AL, NUM1_HIGH
    SBB AL, NUM2_HIGH
    MOV RESULT_HIGH, AL

    ; Display final result
    MOV AH, 09H
    LEA DX, MSG3
    INT 21H

    ; Exit program
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
