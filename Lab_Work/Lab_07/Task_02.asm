
.MODEL SMALL
.STACK 100H

.DATA
    menu DB 13,10,'Select an instruction:',13,10
         DB '1. ADD 7FH, 01H',13,10
         DB '2. SUB 10H, 20H',13,10
         DB 'Enter choice (1-2): $'

    msgCF DB 13,10,'CF = $'
    msgZF DB 13,10,'ZF = $'
    msgSF DB 13,10,'SF = $'
    msgOF DB 13,10,'OF = $'
    msgInvalid DB 13,10,'Invalid choice!$'

    flagsWord DW 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display menu
    LEA DX, menu
    MOV AH, 09H
    INT 21H

    ; Read user choice
    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE DO_ADD

    CMP AL, '2'
    JE DO_SUB

    JMP INVALID

DO_ADD:
    MOV AL, 7FH
    MOV BL, 01H
    ADD AL, BL

    ; Save flags immediately after ADD
    PUSHF
    POP DX
    MOV flagsWord, DX
    JMP DISPLAY_FLAGS

DO_SUB:
    MOV AL, 10H
    MOV BL, 20H
    SUB AL, BL

    ; Save flags immediately after SUB
    PUSHF
    POP DX
    MOV flagsWord, DX
    JMP DISPLAY_FLAGS

INVALID:
    LEA DX, msgInvalid
    MOV AH, 09H
    INT 21H
    JMP EXIT_PROGRAM

DISPLAY_FLAGS:
    ; Display Carry Flag (bit 0)
    LEA DX, msgCF
    MOV AH, 09H
    INT 21H

    MOV AX, flagsWord
    AND AX, 0001H
    JZ CF_ZERO
    MOV DL, '1'
    JMP PRINT_CF

CF_ZERO:
    MOV DL, '0'

PRINT_CF:
    MOV AH, 02H
    INT 21H

    ; Display Zero Flag (bit 6)
    LEA DX, msgZF
    MOV AH, 09H
    INT 21H

    MOV AX, flagsWord
    AND AX, 0040H
    JZ ZF_ZERO
    MOV DL, '1'
    JMP PRINT_ZF

ZF_ZERO:
    MOV DL, '0'

PRINT_ZF:
    MOV AH, 02H
    INT 21H

    ; Display Sign Flag (bit 7)
    LEA DX, msgSF
    MOV AH, 09H
    INT 21H

    MOV AX, flagsWord
    AND AX, 0080H
    JZ SF_ZERO
    MOV DL, '1'
    JMP PRINT_SF

SF_ZERO:
    MOV DL, '0'

PRINT_SF:
    MOV AH, 02H
    INT 21H

    ; Display Overflow Flag (bit 11)
    LEA DX, msgOF
    MOV AH, 09H
    INT 21H

    MOV AX, flagsWord
    AND AX, 0800H
    JZ OF_ZERO
    MOV DL, '1'
    JMP PRINT_OF

OF_ZERO:
    MOV DL, '0'

PRINT_OF:
    MOV AH, 02H
    INT 21H

EXIT_PROGRAM:
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
