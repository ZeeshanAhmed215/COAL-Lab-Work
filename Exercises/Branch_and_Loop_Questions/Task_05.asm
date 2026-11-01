
.MODEL SMALL
.STACK 100H

.DATA
    ARR DB 12H, 07H, 24H, 31H, 56H, 9BH, 0CH, 45H
    LEN EQU 8

    EVEN_CNT DB 0
    ODD_CNT DB 0

    MSG1 DB 'Even Count = $'
    MSG2 DB 0DH, 0AH, 'Odd Count = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Initialize array pointer
    LEA SI, ARR

    MOV CX, LEN

CHECK_LOOP:
    MOV AL, [SI]

    ; Check whether number is even or odd
    TEST AL, 01H
    JZ EVEN_NUMBER

    ; If odd
    INC ODD_CNT
    JMP NEXT_NUMBER

EVEN_NUMBER:
    ; If even
    INC EVEN_CNT

NEXT_NUMBER:
    INC SI
    LOOP CHECK_LOOP

    ; Display even count message
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    ; Display even count in hexadecimal
    MOV AL, EVEN_CNT
    CALL PRINT_HEX

    ; Display odd count message
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    ; Display odd count in hexadecimal
    MOV AL, ODD_CNT
    CALL PRINT_HEX

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Procedure to display 8-bit hexadecimal value
PRINT_HEX PROC
    PUSH AX

    ; Display upper digit
    MOV DL, AL
    MOV CL, 4
    SHR DL, CL
    CALL PRINT_DIGIT

    ; Display lower digit
    POP AX
    AND AL, 0FH
    MOV DL, AL
    CALL PRINT_DIGIT

    RET
PRINT_HEX ENDP

; Procedure to display one hexadecimal digit
PRINT_DIGIT PROC
    CMP DL, 09H
    JBE NUMBER

    ADD DL, 37H
    JMP DISPLAY

NUMBER:
    ADD DL, 30H

DISPLAY:
    MOV AH, 02H
    INT 21H
    RET
PRINT_DIGIT ENDP

END MAIN
