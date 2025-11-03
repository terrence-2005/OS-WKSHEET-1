# Makefile for Operating Systems - Worksheet 1
# Place this in the ROOT directory of your repo (OS-WKSHEET-1)

# This version adds the -Isrc/ flag to all nasm commands
# to fix the "unable to open include file" error.
#
# UPDATED: Changed task2.2 and task2.3 rules to use underscores
# to match your file names (task2_2.asm, task2_3.asm)

.PHONY: all clean

# Default rule
all: task1 task1.2 task2.1 task2.2 task2.3

# --- Rules to Link Final Executables ---
task1: driver.o asm_io.o task1.o
	gcc -m32 -no-pie driver.o task1.o asm_io.o -o task1

task1.2: driver.o asm_io.o task1.2.o
	gcc -m32 -no-pie driver.o task1.2.o asm_io.o -o task1.2

task2.1: driver.o asm_io.o task2.1.o
	gcc -m32 -no-pie driver.o task2.1.o asm_io.o -o task2.1

task2.2: driver.o asm_io.o task2.2.o
	gcc -m32 -no-pie driver.o task2.2.o asm_io.o -o task2.2

task2.3: driver.o asm_io.o task2.3.o
	gcc -m32 -no-pie driver.o task2.3.o asm_io.o -o task2.3

# --- Rules to Compile Object Files ---

# Shared object files
driver.o: src/driver.c
	gcc -m32 -c src/driver.c -o driver.o

# CORRECTED: Added -Isrc/ to the nasm command
asm_io.o: src/asm_io.asm src/asm_io.inc
	nasm -f elf -Isrc/ src/asm_io.asm -o asm_io.o

# Task-specific object files
# CORRECTED: Added -Isrc/ to all nasm commands
task1.o: src/task1.asm src/asm_io.inc
	nasm -f elf -Isrc/ src/task1.asm -o task1.o

task1.2.o: src/task1.2.asm src/asm_io.inc
	nasm -f elf -Isrc/ src/task1.2.asm -o task1.2.o

task2.1.o: src/task2.1.asm src/asm_io.inc
	nasm -f elf -Isrc/ src/task2.1.asm -o task2.1.o

# UPDATED to match your filename src/task2_2.asm
task2.2.o: src/task2_2.asm src/asm_io.inc
	nasm -f elf -Isrc/ src/task2_2.asm -o task2.2.o

# UPDATED to match your filename src/task2_3.asm
# CORRECTED: Removed typo "src:src/"
task2.3.o: src/task2_3.asm src/asm_io.inc
	nasm -f elf -Isrc/ src/task2_3.asm -o task2.3.o

# --- Cleanup Rule ---
clean:
	rm -f *.o task1 task1.2 task2.1 task2.2 task2.3

