# OS-WKSHEET-1
CMMD PRMPT 2 RUN TASK 1 
nasm -f elf task1.2.asm -o task1.2.o
gcc -m32 -no-pie driver.o task1.2.o asm_io.o -o task1.2
./task1.2

--------------------------------------------
CMMD PRMPT 2 RUN TASK 2

TASK2.1
nasm -f elf task2.1.asm -o task2.1.o
gcc -m32 -no-pie driver.o task2.1.o asm_io.o -o task2.1
./task2.1

TASK 2.2 
nasm -f elf task2_2.asm -o task2_2.o
gcc -m32 -no-pie driver.o task2_2.o asm_io.o -o task2_2
./task2_2

TASK 2.3
nasm -f elf task2_3.asm -o task2_3.o
gcc -m32 -no-pie driver.o task2_3.o asm_io.o -o task2_3
./task2_3

------------------
Task 3

"make clean" - to clear all executable files generated so u can start afresh
"make" - to generate new exe files

------------------
Task 4 README
