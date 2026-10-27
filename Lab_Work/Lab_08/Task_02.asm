
.MODEL SMALL
.STACK 100H

.DATA
    msg1 DB 'Enter N (1-9): $'
    msg2 DB 13,10,'Sum of first N positive integers: $'

    N DB ?
    SUM DW 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Input N
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    SUB AL, 30H
    MOV N, AL

    ; Initialize loop
    MOV CX, 0
    MOV CL, N
    MOV AX, 0
    MOV BX, 1

SUM_LOOP:
    ADD AX, BX
    INC BX
    LOOP SUM_LOOP

    MOV SUM, AX

    ; Display message
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    ; Convert sum to decimal digits
    MOV AX, SUM
    MOV BX, 10
    MOV CX, 0

CONVERT_LOOP:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CONVERT_LOOP

    ; Display digits in correct order
DISPLAY_LOOP:
    POP DX
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    LOOP DISPLAY_LOOP

    ; Exit
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
