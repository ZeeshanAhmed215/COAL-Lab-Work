
.MODEL SMALL
.STACK 100H

.DATA
    ARR DB 25H, 8AH, 12H, 0F3H, 44H, 7EH
    LEN EQU 6
    MAX DB ?
    MSG DB 'Largest Number = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Find largest number
    LEA SI, ARR

    MOV AL, [SI]
    MOV MAX, AL

    INC SI
    MOV CX, LEN - 1

CHECK_LOOP:
    MOV AL, [SI]
    CMP AL, MAX
    JBE SKIP

    MOV MAX, AL

SKIP:
    INC SI
    LOOP CHECK_LOOP

    ; Display message
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Display upper hexadecimal digit
    MOV AL, MAX
    MOV BL, AL
    SHR AL, 1
    SHR AL, 1
    SHR AL, 1
    SHR AL, 1

    CALL PRINT_HEX

    ; Display lower hexadecimal digit
    MOV AL, BL
    AND AL, 0FH

    CALL PRINT_HEX

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Display one hexadecimal digit
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
