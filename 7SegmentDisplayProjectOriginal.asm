ASSUME CS:CODE, DS:DATA

DATA SEGMENT
hour DW 00 ; Time Value
minutes DW 00 ; Minutes Value
seconds DW 00 ; Seconds Value
NUMBERS DB 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111101b, 00000111b, 01111111b, 01101111b, 01000000b
DATA ENDS  ;    0         1         2           3          4          5           6          7         8          9          :               

CODE SEGMENT
START:
MOV AX, DATA
MOV DS, AX

;Time: 00:00:00
MOV hour, 00 ; Hour:00
MOV minutes, 00 ; Minutes:00
MOV seconds, 00 ; Seconds:00

;Initially set the time to 00:00:00
CALL DISPLAY_INITIAL_TIME

;Continuous update cycle of hour, minute and second values
MAIN_LOOP:
CALL DELAY_ONE_SECOND
INC seconds ; seconds++
CMP seconds, 60 ; 1 hour = 60 minutes, 1 minutes = 60 seconds
JNE UPDATE_TIME ; Update seconds if not equal

MOV seconds, 0 ; If the second is 60,
INC minutes    ; increase the minute by 1 and reset the second.
CMP minutes, 60
JNE UPDATE_TIME ; Update minutes if not equal

MOV minutes, 0 ; If the minute is 60
INC hour       ; increase the hour by 1 and reset the minutes.
CMP hour, 24 ; 1 day ?= 24 hours
JNE UPDATE_TIME ; Update hours if not equal

MOV hour, 0 ; If the hour is 24 (NEXT DAY), reset the hours

UPDATE_TIME:
CALL DISPLAY_TIME ;Printing time on the screen
JMP MAIN_LOOP

DELAY_ONE_SECOND:
; 1 second delay = 100 miliseccons (ms)

RET

DISPLAY_INITIAL_TIME:
MOV DX, 2030h ;Port address of the initial clock part
MOV AL, NUMBERS[0] ; NUMBERS[0] = 0
OUT DX, AL ; Write the port
INC DX ; Jump to other portç
OUT DX, AL

MOV AL, NUMBERS[10] ; NUMBERS[10] = :
INC DX
OUT DX, AL 

MOV AL, NUMBERS[0]
INC DX
OUT DX, AL
INC DX
OUT DX, AL

MOV AL, NUMBERS[10]
INC DX
OUT DX, AL

MOV AL, NUMBERS[0]
INC DX
OUT DX, AL
INC DX
OUT DX, AL

RET

DISPLAY_TIME:
CALL DISPLAY_HOUR ; Prints the hour on the screen
CALL DISPLAY_MINUTES ; Prints the minutes on the screen
CALL DISPLAY_SECONDS ; Prints the seconds on the screen

RET

DISPLAY_HOUR:
; tens digit value
MOV AX, hour
MOV BL, 10
DIV BL ; Dividing the hour into digits (Ex: 23-> 2 and 3)
MOV AH, 0
MOV SI, AX

MOV AL, NUMBERS[SI]
MOV DX, 2030h
OUT DX, AL ; Print the value on the screen (for 2030h)

; ones digit value
MOV AX, hour
MOV BL, 10
DIV BL
MOV AL, AH
MOV AH, 0
MOV SI, AX
 
MOV AL, NUMBERS[SI]
MOV DX, 2031h
OUT DX, AL


RET

DISPLAY_MINUTES:
; tens digit value
MOV AX, minutes
MOV BL, 10
DIV BL ; Dividing the minutes into digits (Ex: 23-> 2 and 3)
MOV AH, 0
MOV SI, AX

MOV AL, NUMBERS[SI]
MOV DX, 2033h
OUT DX, AL ; Print the value on the screen (for 2033h)

; ones digit value
MOV AX, minutes
MOV BL, 10
DIV BL
MOV AL, AH 
MOV AH, 0
MOV SI, AX 

MOV AL, NUMBERS[SI]
MOV DX, 2034h
OUT DX, AL


RET

DISPLAY_SECONDS:
; tens digit value
MOV AX, seconds
MOV BL, 10
DIV BL ; Dividing the seconds into digits (Ex: 23-> 2 and 3)
MOV AH, 0
MOV SI, AX

MOV AL, NUMBERS[SI]
MOV DX, 2036h
OUT DX, AL ;Print the value on the screen (for 2036h)

; ones digit value
MOV AX, seconds
MOV BL, 10
DIV BL
MOV AL, AH
MOV AH, 0
MOV SI, AX 

MOV AL, NUMBERS[SI]
MOV DX, 2037h
OUT DX, AL


RET

CODE ENDS
END START
