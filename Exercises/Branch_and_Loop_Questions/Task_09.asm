
.MODEL SMALL
.STACK 100H

.DATA
    STR DB 'MADAM'
    LEN EQU 5  

    MSG1 DB 'PALINDROME$'
    MSG2 DB 'NOT PALINDROME$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Initialize pointers
    LEA SI, STR
    LEA DI, STR
    ADD DI, LEN - 1

    ; Loop runs LEN / 2 times
    MOV CX, LEN / 2

CHECK_LOOP:
    ; Compare characters from both ends
    MOV AL, [SI]
    CMP AL, [DI]

    ; If characters do not match
    JNE NOT_PALINDROME

    ; Move pointers
    INC SI
    DEC DI

    LOOP CHECK_LOOP

    ; Display PALINDROME
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    JMP EXIT_PROGRAM

NOT_PALINDROME:
    ; Display NOT PALINDROME
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

EXIT_PROGRAM:
    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
