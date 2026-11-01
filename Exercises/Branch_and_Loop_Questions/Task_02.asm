
.MODEL SMALL
.STACK 100H

.DATA
    MSG DB 'Enter a number (0-9): $'
    RESULT DB 0DH, 0AH, 'Factorial = $'
    FACT DW ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display message
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Take input
    MOV AH, 01H
    INT 21H

    ; Convert ASCII to number
    SUB AL, 30H
    MOV CL, AL
    MOV CH, 0

    ; Initialize factorial
    MOV AX, 1

    ; Check if input is zero
    CMP CX, 0
    JE ZERO_CASE

FACTORIAL_LOOP:
    MOV BX, CX
    MUL BX          ; AX = AX * BX
    LOOP FACTORIAL_LOOP

    JMP STORE_RESULT

ZERO_CASE:
    MOV AX, 1       ; 0! = 1

STORE_RESULT:
    MOV FACT, AX

    ; Display result message
    MOV AH, 09H
    LEA DX, RESULT
    INT 21H

    ; Convert factorial into decimal digits
    MOV AX, FACT
    MOV BX, 10
    MOV CX, 0

CONVERT_LOOP:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CONVERT_LOOP

    ; Display digits
DISPLAY_LOOP:
    POP DX
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    LOOP DISPLAY_LOOP

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
