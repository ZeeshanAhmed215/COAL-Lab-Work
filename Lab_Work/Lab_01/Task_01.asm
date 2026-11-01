.MODEL SMALL          ; Defines a small memory model (one code and one data segment)
.STACK 100H           ; Allocates 256 bytes (100h) for the stack segment

.DATA                 ; Data segment begins here
    ; The '$' character is a delimiter telling DOS where the string ends
    MSG DB 'Hello, World!$' 

.CODE                 ; Code segment begins here
MAIN PROC
    ; Initialize the Data Segment (DS) register
    MOV AX, @DATA     ; Get the address of the data segment
    MOV DS, AX        ; Move it into the Data Segment register

    ; Display the string on the screen
    LEA DX, MSG       ; Load the effective address (offset) of MSG into DX
    MOV AH, 09H       ; DOS function 09h: Print string to standard output
    INT 21H           ; Call DOS interrupt 21h to execute the function

    ; Terminate the program cleanly
    MOV AH, 4CH       ; DOS function 4Ch: Exit program
    INT 21H           ; Call DOS interrupt 21h to return control to the OS

MAIN ENDP
END MAIN              ; Ends the program and points to the starting procedure
