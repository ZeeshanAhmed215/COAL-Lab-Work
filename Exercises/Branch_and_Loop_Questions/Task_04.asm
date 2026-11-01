
.MODEL SMALL
.STACK 100H

.DATA
    ARR DW 1200H, 0A45H, 3FFFH, 0123H, 5678H
    LEN EQU 5
    MIN DW ?

    MSG DB 'Smallest Number = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Initialize array pointer
    LEA SI, ARR

    ; Initialize MIN with first element
    MOV AX, [SI]
    MOV MIN, AX

    ; Move to next word
    ADD SI, 2
    MOV CX, LEN - 1

CHECK_LOOP:
    ; Load current element
    MOV AX, [SI]

    ; Compare current element with MIN
    CMP AX, MIN
    JAE NEXT_ELEMENT

    ; Update MIN if current element is smaller
    MOV MIN, AX

NEXT_ELEMENT:
    ADD SI, 2
    LOOP CHECK_LOOP

    ; Display message
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Display first hexadecimal digit
    MOV AX, MIN
    MOV BX, AX

    MOV CL, 4
    SHR AX, CL
    SHR AX, CL
    SHR AX, CL

    AND AL, 0FH
    CALL PRINT_HEX

    ; Display second hexadecimal digit
    MOV AX, BX
    MOV CL, 4
    SHR AX, CL
    AND AL, 0FH
    CALL PRINT_HEX

    ; Display third hexadecimal digit
    MOV AX, BX
    MOV CL, 4
    SHR AX, CL
    SHR AX, CL
    AND AL, 0FH
    CALL PRINT_HEX

    ; Display fourth hexadecimal digit
    MOV AX, BX
    AND AL, 0FH
    CALL PRINT_HEX

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
