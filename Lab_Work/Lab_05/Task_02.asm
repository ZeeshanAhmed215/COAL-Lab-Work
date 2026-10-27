
.MODEL SMALL
.STACK 100H

.DATA
    msg1   DB 'Enter first digit (0-9): $'
    msg2   DB 13,10,'Enter second digit (0-9): $'
    msg3   DB 13,10,'Enter third digit (0-9): $'
    msg4   DB 13,10,'Sum = $'
    result DW ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Input first digit
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    XOR AH, AH
    MOV BX, AX

    ; Input second digit
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    XOR AH, AH
    ADD BX, AX

    ; Input third digit
    LEA DX, msg3
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    XOR AH, AH
    ADD BX, AX

    ; Store the 16-bit result
    MOV result, BX

    ; Display the sum (single digit or two digits)
    LEA DX, msg4
    MOV AH, 09H
    INT 21H

    MOV AX, result
    MOV CX, 0
    MOV BX, 10

CONVERT:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CONVERT

DISPLAY:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP DISPLAY

    ; Exit
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
