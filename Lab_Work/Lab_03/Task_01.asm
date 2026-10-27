
.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'First number: 1234H',13,10,'$'
    MSG2 DB 'Second number: 00F2H',13,10,'$'
    MSG3 DB 'Sum = 1326H',13,10,'$'

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

    ; Display first number
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    ; Display second number
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    ; Add low bytes
    MOV AL, NUM1_LOW
    ADD AL, NUM2_LOW
    MOV RESULT_LOW, AL

    ; Add high bytes with carry
    MOV AL, NUM1_HIGH
    ADC AL, NUM2_HIGH
    MOV RESULT_HIGH, AL

    ; Display final result
    MOV AH, 09H
    LEA DX, MSG3
    INT 21H

    ; Exit to DOS
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
