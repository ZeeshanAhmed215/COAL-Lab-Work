
.MODEL SMALL
.STACK 100H

.DATA
    msg1   DB 'Enter first digit (0-9): $'
    msg2   DB 13,10,'Enter second digit (0-9): $'
    msg3   DB 13,10,'Absolute difference: $'
    result DB ?

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
    MOV BL, AL

    ; Input second digit
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BH, AL

    ; Compare both numbers
    CMP BL, BH
    JAE FIRST_LARGER

    ; Second number is larger
    MOV AL, BH
    SUB AL, BL
    JMP STORE_RESULT

FIRST_LARGER:
    ; First number is larger or equal
    MOV AL, BL
    SUB AL, BH

STORE_RESULT:
    MOV result, AL

    ; Display result message
    LEA DX, msg3
    MOV AH, 09H
    INT 21H

    ; Convert result to ASCII and display it
    MOV DL, result
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
