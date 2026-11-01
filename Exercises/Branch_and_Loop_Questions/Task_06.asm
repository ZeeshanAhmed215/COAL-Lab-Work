
.MODEL SMALL
.STACK 100H

.DATA
    ARR DB 12H, 0F5H, 00H, 7FH, 80H, 00H, 33H, 0FFH
    LEN EQU 8

    POS DB 0
    NEG_CNT DB 0
    ZERO DB 0

    MSG1 DB 'Positive Count = $'
    MSG2 DB 0DH, 0AH, 'Negative Count = $'
    MSG3 DB 0DH, 0AH, 'Zero Count = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA SI, ARR
    MOV CX, LEN

CHECK_LOOP:
    MOV AL, [SI]

    CMP AL, 0
    JE ZERO_NUMBER

    CMP AL, 0
    JG POSITIVE_NUMBER

    ; Negative number
    INC NEG_CNT
    JMP NEXT_NUMBER

POSITIVE_NUMBER:
    INC POS
    JMP NEXT_NUMBER

ZERO_NUMBER:
    INC ZERO

NEXT_NUMBER:
    INC SI
    LOOP CHECK_LOOP

    ; Display positive count
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    MOV AL, POS
    CALL PRINT_HEX

    ; Display negative count
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    MOV AL, NEG_CNT
    CALL PRINT_HEX

    ; Display zero count
    MOV AH, 09H
    LEA DX, MSG3
    INT 21H

    MOV AL, ZERO
    CALL PRINT_HEX

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Display hexadecimal number
PRINT_HEX PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BL, AL

    ; Upper digit
    MOV CL, 4
    SHR AL, CL
    CALL PRINT_DIGIT

    ; Lower digit
    MOV AL, BL
    AND AL, 0FH
    CALL PRINT_DIGIT

    POP DX
    POP CX
    POP BX
    POP AX

    RET
PRINT_HEX ENDP

; Display one hexadecimal digit
PRINT_DIGIT PROC
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
PRINT_DIGIT ENDP

END MAIN
