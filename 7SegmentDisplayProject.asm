ASSUME CS:CODE DS:DATA

DATA SEGMENT
hour DW 00 ; Hour value
minutes DW 00 ; Minutes value
seconds DW 00 ; Seconds value
DATA ENDS

CODE SEGMENT
START:
MOV AX, DATA
MOV DS, AX

;Time: 00:00:00
MOV hour, 00 ; Hour:00
MOV minutes, 00 ; Minutes:00
MOV seconds, 00 ; Seconds:00

; Update hour, minutes, seconds values in an infinite loop
MAIN_LOOP:
CALL DelayOneSecond
MOV DX, 60 ; 1 Hour = 60 minutes / 1 minutes = 60 seconds (for comparision)
INC seconds ;seconds ++
MOV AX, seconds
CMP AX, DX ;Is equal or not?
JNE UPDATE_DISPLAY ;If not equal, it allows to go back to the beginning to increase continuously (for seconds)

MOV seconds,00 ;When the second is 60, the minute increments by 1,
               ;the second is reset to zero to count from the beginning.
INC minutes; minutes ++
MOV AX, minutes
CMP AX, DX ; Is equal or not?
JNE UPDATE_DISPLAY ;If not equal, it allows to go back to the beginning to increase continuously (for minutes)

MOV minutes, 00 ;When the minutes is 60, the hour increments by 1,
                ;the seconds and minutes is reset to zero to count from the beginning.
INC hour
MOV AX, hour
CMP AX, 24 ; Is equal or not?
JNE UPDATE_DISPLAY ;If not equal, it allows to go back to the beginning to increase continuously (for hour)

MOV hour, 00 ;When the hour is 24, the hour,
             ;seconds and minutes are reset to zero to count from the beginning. (Next day)

UPDATE_DISPLAY:
JMP MAIN_LOOP

DelayOneSecond:
;1 seconds delay = 100 milliseconds(ms)
RET

CODE ENDS
END START