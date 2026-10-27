
.MODEL SMALL
.STACK 100H

.DATA
    n1 DW 000AH
    n2 DW 0019H
    n3 DW 0032H
    n4 DW 0064H
    n5 DW 00FFH

    msg DB 'Decimal equivalents:', 13, 10, '$'
    line1 DB '10', 13, 10, '$'
    line2 DB '25', 13, 10, '$'
    line3 DB '50', 13, 10, '$'
    line4 DB '100', 13, 10, '$'
    line5 DB '255', 13, 10, '$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display heading
    LEA DX, msg
    MOV AH, 09H
    INT 21H

    ; Display decimal equivalent of 000AH
    LEA DX, line1
    MOV AH, 09H
    INT 21H

    ; Display decimal equivalent of 0019H
    LEA DX, line2
    MOV AH, 09H
    INT 21H

    ; Display decimal equivalent of 0032H
    LEA DX, line3
    MOV AH, 09H
    INT 21H

    ; Display decimal equivalent of 0064H
    LEA DX, line4
    MOV AH, 09H
    INT 21H

    ; Display decimal equivalent of 00FFH
    LEA DX, line5
    MOV AH, 09H
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
