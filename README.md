# CEN212 Microprocessors Project
## ⏳Time Display with 7 Segment Indicator
### 📍Project Description and Purpose
<p>
This project aims to create a digital clock using a 7 segment display. When the microprocessor is energised, 00:00:00 will be displayed as the start time. Then, using delay functions, the hour, minute and second values will be updated in real time. The user will be able to set the time using the hour select, minute select, increment and decrement keys. The seconds value will be reset automatically when the time is set.

In addition, an alarm function will be integrated into the project. This alarm function will enable the alarm to sound at the time specified by the user and the user will be able to enable or disable the alarm at any time.

This project aims to provide a basic digital watch structure as well as an enhanced watch experience with a user-friendly interface and additional functions. It also aims to simulate the real life functions of digital clocks in a virtual environment by using microprocessor and 7 segment display.

**Note:** *The programme is written in assembly code and the code is planned to run only on 8086.*
</p>

### 🔧Equipment List and Requirements
- Microprocessor (8086)
- 7 Segment Display
- Emulator (emu8086)
- Simulation Environment (Proteus)

**Note:** *The relevant equipment to be used in the project will be provided in a virtual environment via Proteus (Microprocessor - 7 Segment Display).*

### 📜Project Construction
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
At the start of the programme, the hour, minute and second values are initialised as 00.00.00.00. For this, the value 00 is loaded loaded to hour, minute and second variables.
```
    MOV hour, 00
    MOV minutes, 00
    MOV seconds, 00 
```
To update the hour, minute and second values in an infinite loop, an infinite loop named MAIN_LOOP is used. Here the procedure called DelayOneSecond is called with the CALL command. This is used for the delay in milliseconds for a delay of 1 second. Then the value 60 is loaded into the DX register. This is a reference in 60 seconds for 1 minute. It is also a 60-minute reference for 1 hour. 
```
MAIN_LOOP:
    CALL DelayOneSecond
    MOV DX, 60
```
After the relevant uploads are made, the seconds is increased. The seconds variable is loaded into the AX register and then the values in the AX and DX registers are compared with the CMP instruction. If these two values are not equal to each other, JNE instruction is used to go back to the beginning (to increase the second continuously) with UPDATE_DISPLAY.
```
INC seconds
MOV AX, seconds
CMP AX, DX
JNE UPDATE_DISPLAY
```
If the values in the AX and DX registers are equal (60), the seconds variable is reset to zero and the minutes variable is incremented by one. Then minute value is assigned to AX variable and AX - DX comparison is done again with CMP. This is to update the clock value if the minute value is equal to 60. If these two values are not equal to each other, JNE instruction is used to go back to the beginning with UPDATE_DISPLAY.
```
MOV seconds, 00
INC minutes
MOV AX, minutes
CMP AX, DX
JNE UPDATE_DISPLAY
```
If the minute value is equal to 60, to update the clock value, the values in the minute and second variables are reset by assigning zero with the MOV instruction and the clock is incremented by one with the INC instruction. Then the clock value is assigned to the AX register and 24 is compared with the clock value in the AX register with the CMP instruction. If these two values are not equal to each other, JNE instruction is used to go back to the beginning with UPDATE_DISPLAY.
```
MOV minutes, 00
INC hour
MOV AX, hour
CMP AX, 24
JNE UPDATE_DISPLAY
```
If the time is equal to 24, the clock value is reset to zero to move to the next day.
```
MOV hour, 00
```
The JMP command jumps to MAIN_LOOP, which ensures continuous time updating. 
```
UPDATE_DISPLAY:
    JMP MAIN_LOOP
```
The DelayOneSecond procedure shall not take any action to provide a delay of one second. Normally there are several methods to provide a one second delay. In this programme we wanted to provide this by leaving the procedure empty.
```
DelayOneSecond:
;1 seconds delay = 100 milliseconds(ms)
RET
```
```
CODE ENDS
END START
```
![emu8086_rz68okf92d](https://github.com/Berkantagur/CEN212-Microprocessors-Project/assets/113332304/9656bab1-722c-4fe4-ad37-b5eb95dcfb67)
![emu8086_fNzSCH8xDM](https://github.com/Berkantagur/CEN212-Microprocessors-Project/assets/113332304/f0d3af14-35d6-47a7-ba5b-29ae08077740)

</details>
<details>
  <summary>Compilation and Testing</summary>
  When we run our code on emu8086, our clock counts according to the 100 millisecond delay time we initially referenced. We did not use the IN command because we did not have a physical circuit. Instead, the user can change the values by double-clicking the desired part on the screen to enter the values and continue counting from the desired location. The best logic here was to switch to the new day when the clock was 23.59.59.59 and the counter started counting from the new day as 00.00.00.00 as if the programme was energised.
  <br>
  ![7SegmentDisplayGif](https://github.com/Berkantagur/CEN212-Microprocessors-Project/assets/113332304/508cd21b-440d-420c-978b-00d98db4ad55)
  <br>
  Although the project result we wanted was not fully met, we achieved our goal over 85%. Because we have a programme that shows the hour, minute and second values and allows us to set it as we want when we want and then continue from where it left off. But we were not satisfied with what we had, we did countless research on how to visualise it more beatiful. Through the demo version of Proteus software, we designed what it would look like if we had a physical circuit.
  <br>
  ![7SegmentDisplayCircuit](https://github.com/Berkantagur/CEN212-Microprocessors-Project/assets/113332304/1ac64029-0fa5-45f0-9984-32f9b685f447)
  <br>
  If we had the physical facilities, we would love to show you this, but this is all we could do based on our research.

</details>

### ♾️Conclision
At the end of the project, we gained many more valuable things besides completing the task given to us. We experienced many things, such as how to work in a team, cooperation, task sharing. We had the opportunity to develop our project management and research skills that we will use in our future lives. We would like to thank our esteemed teacher Assoc. Prof. Dr. Mustafa Berkan BİÇER for his contributions to us as soft skills acquisition.

### 🤖Contributors
- 2022555056 Asusena Ela ÖZTÜRK
- 2021555001 Berkant AĞUR
- 2022555035 Emre KAHRAMAN
- 2021555503 Tuğçe ÇALIŞOĞLU
