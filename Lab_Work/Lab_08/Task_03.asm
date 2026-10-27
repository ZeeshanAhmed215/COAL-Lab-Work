
.MODEL SMALL
.STACK 100H

.DATA
    menu DB 13,10,'===== CLASSIFICATION MENU =====',13,10
         DB '1. Positive Number',13,10
         DB '2. Negative Number',13,10
         DB '3. Zero',13,10
         DB '4. Even Number',13,10
         DB 'Enter your choice (1-4): $'

    msg1 DB 13,10,'Case 1: Positive Number selected.$'
    msg2 DB 13,10,'Case 2: Negative Number selected.$'
    msg3 DB 13,10,'Case 3: Zero selected.$'
    msg4 DB 13,10,'Case 4: Even Number selected.$'
    invalid DB 13,10,'Invalid choice! Please enter 1-4.$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display menu
    LEA DX, menu
    MOV AH, 09H
    INT 21H

    ; Read choice
    MOV AH, 01H
    INT 21H

    ; Compare choice with four cases
    CMP AL, '1'
    JE CASE1

    CMP AL, '2'
    JE CASE2

    CMP AL, '3'
    JE CASE3

    CMP AL, '4'
    JE CASE4

    JMP INVALID_CHOICE

CASE1:
    LEA DX, msg1
    JMP DISPLAY_MSG

CASE2:
    LEA DX, msg2
    JMP DISPLAY_MSG

CASE3:
    LEA DX, msg3
    JMP DISPLAY_MSG

CASE4:
    LEA DX, msg4
    JMP DISPLAY_MSG

INVALID_CHOICE:
    LEA DX, invalid

DISPLAY_MSG:
    MOV AH, 09H
    INT 21H

    ; Exit program
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
