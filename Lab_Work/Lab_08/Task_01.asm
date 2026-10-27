
.MODEL SMALL
.STACK 100H

.DATA
    msg1    DB 'Enter first number (0-9): $'
    msg2    DB 13,10,'Enter second number (0-9): $'
    msg3    DB 13,10,'Enter third number (0-9): $'

    entered DB 13,10,13,10,'You entered: $'
    comma   DB ', $'

    first   DB 13,10,'First number is the largest: $'
    second  DB 13,10,'Second number is the largest: $'
    third   DB 13,10,'Third number is the largest: $'

    n1      DB ?
    n2      DB ?
    n3      DB ?
    largest DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Input first number
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV n1, AL

    ; Input second number
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV n2, AL

    ; Input third number
    LEA DX, msg3
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV n3, AL

    ; Display all three numbers
    LEA DX, entered
    MOV AH, 09H
    INT 21H

    MOV DL, n1
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    LEA DX, comma
    MOV AH, 09H
    INT 21H

    MOV DL, n2
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    LEA DX, comma
    MOV AH, 09H
    INT 21H

    MOV DL, n3
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    ; Compare first number with second
    MOV AL, n1
    CMP AL, n2
    JB CHECK_SECOND

    ; First must also be >= third
    CMP AL, n3
    JB CHECK_SECOND

    MOV largest, AL

    LEA DX, first
    MOV AH, 09H
    INT 21H
    JMP DISPLAY_LARGEST

CHECK_SECOND:
    MOV AL, n2
    CMP AL, n3
    JB THIRD_LARGEST

    MOV largest, AL

    LEA DX, second
    MOV AH, 09H
    INT 21H
    JMP DISPLAY_LARGEST

THIRD_LARGEST:
    MOV AL, n3
    MOV largest, AL

    LEA DX, third
    MOV AH, 09H
    INT 21H

DISPLAY_LARGEST:
    MOV DL, largest
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
