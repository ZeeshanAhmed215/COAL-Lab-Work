
.MODEL SMALL
.STACK 100H

.DATA
    msg1 DB 'Enter 8-bit binary input (0 or 1): $'
    msg2 DB 13,10,'Number of 1s = $'

    inputNum DB 0
    onesCount DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Ask for 8-bit binary input
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    ; Read 8 binary digits and build the byte
    MOV BL, 0
    MOV CX, 8

INPUT_LOOP:
    MOV AH, 01H
    INT 21H

    SHL BL, 1
    CMP AL, '1'
    JNE NEXT_BIT
    OR BL, 1

NEXT_BIT:
    LOOP INPUT_LOOP

    MOV inputNum, BL

    ; Count the number of 1 bits
    MOV BL, inputNum
    MOV CX, 8
    MOV DH, 0

COUNT_LOOP:
    SHR BL, 1
    JNC NO_ONE
    INC DH

NO_ONE:
    LOOP COUNT_LOOP

    MOV onesCount, DH

    ; Display the count
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    MOV DL, onesCount
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
