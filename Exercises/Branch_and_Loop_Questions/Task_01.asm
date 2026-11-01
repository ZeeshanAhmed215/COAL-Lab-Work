
.MODEL SMALL
.STACK 100H

.DATA
    MSG DB 'Enter N: $'
    RESULT DB 0DH, 0AH, 'Sum = $'
    SUM DW ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display input message
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Take input from user
    MOV AH, 01H
    INT 21H

    ; Convert ASCII to number
    SUB AL, 30H
    MOV CL, AL
    MOV CH, 0

    ; Initialize sum
    MOV AX, 0
    MOV BX, 1

    ; Calculate sum using LOOP
L1:
    ADD AX, BX
    INC BX
    LOOP L1

    ; Store result
    MOV SUM, AX

    ; Display result message
    MOV AH, 09H
    LEA DX, RESULT
    INT 21H

    ; Display sum (for single-digit N, result may be two digits)
    MOV AX, SUM
    MOV BL, 10
    DIV BL

    MOV BH, AH
    MOV DL, AL
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    MOV DL, BH
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
