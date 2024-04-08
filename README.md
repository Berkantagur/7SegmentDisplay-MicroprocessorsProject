# CEN212 Microprocessors Project
## 📍Time Display with 7 Segment Indicator
### Project Description and Purpose
<p>
This project aims to create a digital clock using a 7 segment display. When the microprocessor is energised, 00:00:00 will be displayed as the start time. Then, using delay functions, the hour, minute and second values will be updated in real time. The user will be able to set the time using the hour select, minute select, increment and decrement keys. The seconds value will be reset automatically when the time is set.

In addition, an alarm function will be integrated into the project. This alarm function will enable the alarm to sound at the time specified by the user and the user will be able to enable or disable the alarm at any time.

This project aims to provide a basic digital watch structure as well as an enhanced watch experience with a user-friendly interface and additional functions. It also aims to simulate the real life functions of digital clocks in a virtual environment by using microprocessor and 7 segment display.

**Note:** *The programme is written in assembly code and the code is planned to run only on 8086.*
</p>

### Equipment List and Requirements
- Microprocessor (8086)
- 7 Segment Display
- Emulator (emu8086)
- Simulation Environment (Proteus)

**Note:** *The relevant equipment to be used in the project will be provided in a virtual environment via Proteus (Microprocessor - 7 Segment Display).*

### Project Construction
In this section, we will explain step by step how we built our project. Firstly, we created the project plan and then we proceeded by writing assembly codes on the emu8086 simulator according to our needs. We developed various solutions according to whether our needs were met or not and integrated our digital clock to work in harmony with our code. Finally, we completed our project by performing various tests.

**Note:** *You can access the details by clicking on the relevant project stages from the drop-down menu.*
<details>
  <summary>Project Plan</summary>
  We created a project plan to identify the main purpose of the project, which set out in detail the requirements and operation of the project.
</details>
<details>
  <summary>Writing Assembly Codes</summary>
  
  Using the emu8086 simulator, we wrote the assembly codes that will ensure the functioning of the project.
  
```
ASSUME CS:CODE, DS:DATA
```
Three fields of 16 bits each (2 bytes = 1 word) are defined in the data segment to store the hour, minute and second values. Since the hour, minute and second will be started as 00.00.00 at the beginning, we set each of them as 00 with the DW (Define Word) command. Since the programme will start counting in the following stages, these values will change.
```
DATA SEGMENT
hour  DW 00
minutes  DW 00
seconds  DW 00 
DATA ENDS
```
```
CODE SEGMENT
```
The start address of the data segment is taken under the START tag created in the code segment and then this address is loaded into the DS (Data Segment) register. In this way, the variables in the data segment of the programme can be accessed and these variables can be used in the following stages and the current versions of the relevant values such as hours, minutes, seconds can be stored when the count starts.
```
START:
    MOV AX, DATA
    MOV DS, AX
```
At the start of the programme, the hour, minute and second values are initialised as 00.00.00.00. For this, the value 00 is loaded into the AX register first. Then it is loaded to hour, minute and second variables via AX.
```
    MOV AX, 00
    MOV [hour], AX
    MOV [minutes], AX
    MOV [seconds], AX
```
To update the hour, minute and second values in an infinite loop, the value 1000 is loaded into the CX register first. This is the reference in milliseconds for a delay of 1 second. Then the value 60 is loaded into the DX register. This is a reference of 60 seconds for 1 minute. After the related loads are done, the loop named HOUR_LOOP is jumped to update the clock value.
```
    MOV CX, 1000
    MOV DX, 60  
    JMP HOUR_LOOP
```
In the clock cycle, the second value is increased by 1 by 1 with the help of the INC instruction and when it reaches 60, the second value is compared with the value in the DX register (whether it is equal to 60 or not) with the help of the CMP instruction. If it is not equal, a jump is made to the MINUTES_UPDATE tag with the JNE instruction (to continue counting these seconds and return to the beginning). If it is equal, the minute is increased by 1 and the second value is reset to 00.
```
HOUR_LOOP:
    INC [seconds]
    CMP [seconds], DX
    JNE MINUTES_UPDATE

    INC [minutes]
    MOV [seconds], 00
```
When the minute value is 60, control is provided to increase the hour value. With the CMP instruction, the 60 value in the DX register and the minute value are compared. If the minute value is still not 60, there is no need to update the clock value and return directly to the loop. (For this, go to the HOUR_UPDATE loop.) If it is equal, the clock value is increased by 1 with the INC instruction and the minute variable is reset to 00 with the MOV instruction.
```
MINUTES_UPDATE:
    CMP [minutes], DX
    JNE HOUR_UPDATE

    INC [hour]
    MOV [minutes], 00
```
To update the indicator, the INDICATOR_UPDATE procedure is called with the CALL command. This procedure updates the indicator according to the current clock value. The value 1000 is then loaded into the CX register to provide a one second delay, which is the number of milliseconds in 1 second. The CALL DELAY command calls the DELAY procedure to provide a 1 second delay. JMP HOUR_LOOP jumps to the loop at the beginning of the programme. This allows the unequal values controlled by the JNE instructions to be incremented. In other words, it allows the programme to count continuously and update the hour, minute and second values.
```
HOUR_UPDATE:
    CALL INDICATOR_UPDATE

    MOV CX, 1000
    CALL DELAY

    JMP HOUR_LOOP
```
INDICATOR_UPDATE PROC starts a procedure called INDICATOR_UPDATE to update the indicator. The RET command is used at the end of the procedure to return to the original call point after execution.
```
INDICATOR_UPDATE PROC
    RET
INDICATOR_UPDATE ENDP
```
The DELAY procedure shall not take any action to provide a delay of one second. Normally there are several methods to provide a one second delay. In this programme we wanted to provide this by leaving the procedure empty.
```
DELAY PROC
    RET
DELAY ENDP
```

```
CODE ENDS
END START
```

</details>
<details>
  <summary>Compilation and Testing</summary>
</details>
