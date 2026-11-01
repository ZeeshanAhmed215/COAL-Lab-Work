
.MODEL SMALL
.STACK 100H

.DATA
    ARR DB 64H, 19H, 0A2H, 05H, 3CH, 77H
    LEN EQU 6

    MSG DB 'Sorted Array = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Outer loop (LEN - 1 passes)
    MOV CX, LEN - 1

OUTER_LOOP:
    PUSH CX

    ; Inner loop
    MOV BX, LEN - 1
    LEA SI, ARR

INNER_LOOP:
    ; Load two adjacent elements
    MOV AL, [SI]
    MOV DL, [SI+1]

    ; Compare unsigned numbers
    CMP AL, DL
    JBE NO_SWAP

    ; Swap elements
    MOV [SI], DL
    MOV [SI+1], AL

NO_SWAP:
    INC SI
    DEC BX
    JNZ INNER_LOOP

    POP CX
    LOOP OUTER_LOOP

    ; Display message
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Display sorted array
    LEA SI, ARR
    MOV CX, LEN

DISPLAY_LOOP:
    MOV AL, [SI]
    MOV BL, AL

    ; Display upper hexadecimal digit
    SHR AL, 1
    SHR AL, 1
    SHR AL, 1
    SHR AL, 1
    CALL PRINT_HEX

    ; Display lower hexadecimal digit
    MOV AL, BL
    AND AL, 0FH
    CALL PRINT_HEX

    INC SI
    DEC CX
    JZ EXIT_PROGRAM

    ; Display comma and space
    MOV AH, 02H
    MOV DL, ','
    INT 21H

    MOV DL, ' '
    INT 21H

    JMP DISPLAY_LOOP

EXIT_PROGRAM:
    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Procedure to display hexadecimal digit
PRINT_HEX PROC
    CMP AL, 09H
    JBE NUMBER

    ADD AL, 37H
    JMP DISPLAY

NUMBER:
    ADD AL, 30H

DISPLAY:
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    RET
PRINT_HEX ENDP

END MAIN
