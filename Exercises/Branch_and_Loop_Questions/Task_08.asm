                                                   
.MODEL SMALL
.STACK 100H

.DATA
    STR DB 'MICROPROCESSOR', '$'
    LEN EQU 14

    MSG DB 'Reversed String = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Initialize SI at starting position
    LEA SI, STR

    ; Initialize DI at last character
    LEA DI, STR
    ADD DI, LEN - 1

REVERSE_LOOP:
    ; Compare both pointers
    CMP SI, DI
    JAE DISPLAY_RESULT

    ; Swap characters
    MOV AL, [SI]
    MOV BL, [DI]

    MOV [SI], BL
    MOV [DI], AL

    ; Move pointers
    INC SI
    DEC DI

    JMP REVERSE_LOOP

DISPLAY_RESULT:
    ; Display message
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Display reversed string
    MOV AH, 09H
    LEA DX, STR
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
