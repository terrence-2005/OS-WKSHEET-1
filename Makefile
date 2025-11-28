# Makefile for Operating Systems - Worksheet 1

# the src/ folder for all .asm files prevents typos.

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

asm_io.o: src/asm_io.asm src/asm_io.inc
	nasm -f elf -Isrc/ src/asm_io.asm -o asm_io.o

# --- SMART PATTERN RULE ---
# This rule says: "To build ANY .o file (like task1.o),
# look for the matching .asm file inside src/ (like src/task1.asm)."
# It automatically adds the src/ prefix and the -Isrc/ flag.
%.o: src/%.asm src/asm_io.inc
	nasm -f elf -Isrc/ $< -o $@

# --- Cleanup Rule ---
# UPDATED: Now cleans .o files in both root and src/ directories
clean:
	rm -f *.o src/*.o task1 task1.2 task2.1 task2.2 task2.3