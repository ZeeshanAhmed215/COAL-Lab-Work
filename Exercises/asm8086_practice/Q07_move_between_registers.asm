; Q7. Move data between registers (inspect AX and BX in the debugger)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
msg DB 'Check AX and BX in the debugger (both = 1234h)$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV AX, 1234h
    MOV BX, AX          ; BX = 1234h
    NOP                 ; <-- set a breakpoint here and view AX, BX
    LEA DX, msg
    MOV AH, 09h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
