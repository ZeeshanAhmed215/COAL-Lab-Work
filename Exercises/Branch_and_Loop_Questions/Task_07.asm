
.MODEL SMALL
.STACK 100H

.DATA
    STR DB 'ASSEMBLY LANGUAGE PROGRAMMING', '$'
    COUNT DB 0

    MSG DB 'Total Vowels = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Initialize string pointer
    LEA SI, STR

CHECK_LOOP:
    ; Load current character
    MOV AL, [SI]

    ; Check string terminator
    CMP AL, '$'
    JE FINISH

    ; Check vowel A
    CMP AL, 'A'
    JE VOWEL_FOUND

    ; Check vowel E
    CMP AL, 'E'
    JE VOWEL_FOUND

    ; Check vowel I
    CMP AL, 'I'
    JE VOWEL_FOUND

    ; Check vowel O
    CMP AL, 'O'
    JE VOWEL_FOUND

    ; Check vowel U
    CMP AL, 'U'
    JE VOWEL_FOUND

    JMP NEXT_CHAR

VOWEL_FOUND:
    INC COUNT

NEXT_CHAR:
    INC SI
    JMP CHECK_LOOP

FINISH:
    ; Display message
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Display count in hexadecimal
    MOV AL, COUNT
    CALL PRINT_HEX

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Procedure to display hexadecimal number
PRINT_HEX PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BL, AL

    ; Display upper hexadecimal digit
    MOV CL, 4
    SHR AL, CL
    CALL PRINT_DIGIT

    ; Display lower hexadecimal digit
    MOV AL, BL
    AND AL, 0FH
    CALL PRINT_DIGIT

    POP DX
    POP CX
    POP BX
    POP AX

    RET
PRINT_HEX ENDP

; Procedure to display one hexadecimal digit
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
