; Q23. Vowel or consonant (reads a character from the keyboard)
; 8086 assembly (MASM/TASM/EMU8086 compatible, DOS INT 21h)
.MODEL SMALL
.STACK 100h
.DATA
prompt DB 'Enter a letter: $'
msgV DB 13, 10, 'It is a VOWEL$'
msgC DB 13, 10, 'It is a CONSONANT$'
msgX DB 13, 10, 'Not a letter$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, prompt
    MOV AH, 09h
    INT 21h
    MOV AH, 01h         ; read char with echo -> AL
    INT 21h
    OR  AL, 20h         ; convert to lowercase
    CMP AL, 'a'
    JB  NOT_LETTER
    CMP AL, 'z'
    JA  NOT_LETTER
    CMP AL, 'a'
    JE  VOWEL
    CMP AL, 'e'
    JE  VOWEL
    CMP AL, 'i'
    JE  VOWEL
    CMP AL, 'o'
    JE  VOWEL
    CMP AL, 'u'
    JE  VOWEL
    LEA DX, msgC
    JMP SHOW
VOWEL:
    LEA DX, msgV
    JMP SHOW
NOT_LETTER:
    LEA DX, msgX
SHOW:
    MOV AH, 09h
    INT 21h
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
