.globl main # label ‘main’ is visible to operating system and other programs
.text # text directive that defines where the program instructions go
main: # label to say where our program should start from
	li t6, 110 # load 110 into t6, which is the binary representation of the char 'n'
	
	la a0, intro_str # put address of intro_str into a0
	li a7, 4 # put value 4 into a7 to indicate printstring
	ecall # ecall to print welcome statement
	
	while: # label to indicate start of while loop
		li t0, 0 # set total_ones equal to 0, load it into t0
		li t4, 0 # set result equal to 0, load it into t4
		
		la a0, enter_number_str # put address of enter_number_str into a0
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall # ecall to print enter number statement
		
		li a7, 5 # put value 5 into a7 to indicate readint
		ecall # ecall to read an int from input console
		mv t1, a0 # store user int in t1
		
		for: # label to say where forloop will load its iterator, c
			li t2, 31 # c = 31, load it into t2
		forloop: # label to say where each iteration of the forloop starts from
			blt t2, zero, end_while # goes to end_while if c < 0
			sra t4, t1, t2 # set result equal to user_int bit shifted by c
			
			if: # label to say where if statement starts
				andi t5, t4, 1 # set t5 to result & 1
				beqz t5, endif # go to endif label if result & 1 = 0
				addi t0, t0, 1 # increment total_ones by 1
			endif: # label to say where if statement ends
			addi t2, t2, -1 # decrement c by 1
			b forloop # loop back to the start of forloop
	end_while: # label to indicate end of while loop
		li a7, 4 # put value 4 into a7 to indicate printstring
		la a0, bits_str # put address of bits_str into a0
		ecall # ecall to print bits statement
			
		li a7, 1 # put value 1 into a7 to indicate printint
		mv a0, t0 # put total_ones into a0
		ecall # ecall to print the number of bits set to 1
		
		la a0, continue_str # put address of continue_str into a0
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall # ecall to print continue statement
			
		li a7, 12 # put value 12 into a7 to indicate readchar
		ecall # ecall to read a char from input console
		mv t3, a0 # store user char in t3
		cont_if: # label to indicate where the continue if statement starts
			beq t3, t6, end # branch to end if the user char is 'n'
			b while # branch to while if the user char is anything other than 'n'
		
	end: # label to indicate end of the program
		la a0, exit_str # put address of exit_str into a0
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall # ecall to print exit statement
		li a7, 10 # put value 10 into a7 to indicate exit
		ecall # ecall to exit program
	
.data # data directive defines where the program data goes
intro_str: .string "Welcome to the CountOnes program."
enter_number_str: .string "\n\nPlease enter a number: "
bits_str: .string "The number of bits set is: "
continue_str: .string "\nContinue (y/n)?: "
exit_str: .string "\nExiting"
