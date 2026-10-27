                                         
.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Test 1: F0H + 30H = 20H -> CARRY (CF=1, OF=0)',13,10,'$'
    MSG2 DB 'Test 2: 10H - 20H = F0H -> BORROW (CF=1, OF=0)',13,10,'$'
    MSG3 DB 'Test 3: 7FH + 01H = 80H -> SIGNED OVERFLOW (CF=0, OF=1)',13,10,'$'
    MSG4 DB 'Test 4: 25H + 10H = 35H -> NO EXCEPTION (CF=0, OF=0)',13,10,'$'

    RESULT1 DB ?
    RESULT2 DB ?
    RESULT3 DB ?
    RESULT4 DB ?

    FLAGS1 DW ?
    FLAGS2 DW ?
    FLAGS3 DW ?
    FLAGS4 DW ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Test 1: Unsigned carry
    MOV AL, 0F0H
    ADD AL, 30H
    MOV RESULT1, AL
    PUSHF
    POP DX
    MOV FLAGS1, DX

    ; Test 2: Unsigned borrow
    MOV AL, 10H
    SUB AL, 20H
    MOV RESULT2, AL
    PUSHF
    POP DX
    MOV FLAGS2, DX

    ; Test 3: Signed overflow
    MOV AL, 7FH
    ADD AL, 01H
    MOV RESULT3, AL
    PUSHF
    POP DX
    MOV FLAGS3, DX

    ; Test 4: No exceptional condition
    MOV AL, 25H
    ADD AL, 10H
    MOV RESULT4, AL
    PUSHF
    POP DX
    MOV FLAGS4, DX

    ; Display test results
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    MOV AH, 09H
    LEA DX, MSG3
    INT 21H

    MOV AH, 09H
    LEA DX, MSG4
    INT 21H

    ; Exit program
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
