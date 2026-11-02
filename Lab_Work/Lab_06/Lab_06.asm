
.MODEL SMALL
.STACK 100H

.DATA
    ADD_FLAG DW ?
    SUB_FLAG DW ?
    AND_FLAG DW ?
    OR_FLAG  DW ?
    XOR_FLAG DW ?

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ;-------------------------
    ; ADD INSTRUCTION
    ;-------------------------
    MOV AL, 7FH
    ADD AL, 01H

    PUSHF
    POP BX
    MOV ADD_FLAG, BX

    ;-------------------------
    ; SUB INSTRUCTION
    ;-------------------------
    MOV AL, 00H
    SUB AL, 01H

    PUSHF
    POP BX
    MOV SUB_FLAG, BX

    ;-------------------------
    ; AND INSTRUCTION
    ;-------------------------
    MOV AL, 0FH
    AND AL, 0FH

    PUSHF
    POP BX
    MOV AND_FLAG, BX

    ;-------------------------
    ; OR INSTRUCTION
    ;-------------------------
    MOV AL, 80H
    OR AL, 01H

    PUSHF
    POP BX
    MOV OR_FLAG, BX

    ;-------------------------
    ; XOR INSTRUCTION
    ;-------------------------
    MOV AL, 0FFH
    XOR AL, 0FFH

    PUSHF
    POP BX
    MOV XOR_FLAG, BX

    ; EXIT PROGRAM
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
