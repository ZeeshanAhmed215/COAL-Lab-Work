
.MODEL SMALL
.STACK 100H

.DATA
    msg1 DB 'Enter a single digit (0-9): $'
    evenMsg DB 13,10,'The number is EVEN.$'
    oddMsg DB 13,10,'The number is ODD.$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Ask the user for input
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    ; Read one digit
    MOV AH, 01H
    INT 21H

    ; Convert ASCII to numeric value
    SUB AL, 30H

    ; Test the least significant bit
    TEST AL, 01H
    JZ IS_EVEN

IS_ODD:
    LEA DX, oddMsg
    MOV AH, 09H
    INT 21H
    JMP EXIT_PROGRAM

IS_EVEN:
    LEA DX, evenMsg
    MOV AH, 09H
    INT 21H

EXIT_PROGRAM:
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
