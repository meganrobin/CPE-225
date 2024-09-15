#Name: Megan Robinson
.global main
.text # text directive that defines where the program instructions go
main:
	bigwhile: # label to indicate start of the big while loop
		# ask user to enter first word
		la a0, enterfirststr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# store first word
		la a0, savedfirstword # load address of first word into a0
		jal readstring
		
		# ask user to enter second word
		la a0, entersecondstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# store second word
		la a0, savedsecondword # load address of second word into a0
		jal readstring
		
		# print the first word
		la a0, firstwordstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedfirstword
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# print the second word
		la a0, secondwordstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedsecondword
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# strlen - print the length of the first word
		la a0, firstlengthstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedfirstword
		jal strlen
		li a7, 1 # put value 1 into a7 to indicate printint
		ecall # ecall to print the int in a0
		
		# strlen - print the length of the second word
		la a0, secondlengthstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedsecondword
		jal strlen
		li a7, 1 # put value 1 into a7 to indicate printint
		ecall # ecall to print the int in a0
		
		# strcmp - see if the two words are the same
		la a0, firstlengthstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedfirstword
		la a1, savedsecondword
		jal strcmp
		cmpif: # if strcmp returns 1 (strings are different)
			beqz a0, cmpelse
			la a0, diffstr
			b cmpendif
		cmpelse: # if strcmp returns 0 (strings are the same)
			la a0, samestr
		cmpendif:
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# strcmp - copy a word to a new destination address (the address is that of copiedword)
		la a0, copystr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedsecondword
		la a1, copiedword
		jal strcpy
		
		la a0, copiedword # print the copied word
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# strrev - reverse a word and copy the word to a new destination address (the address is that of copiedword)
		la a0, revstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedfirstword
		la a1, reversedword
		jal strrev
		
		la a0, reversedword # print the copied word
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# strcat - add second word to first word, store in new destination address (the address is that of copiedword)
		la a0, catstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedfirstword
		la a1, savedsecondword
		la a2, concatenatedword
		jal strcat
		
		la a0, concatenatedword # print the concatenated word
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# strmix - add second word to first word alternatingly, store in new destination address (the address is that of copiedword)
		la a0, mixstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedfirstword
		la a1, savedsecondword
		la a2, blendedword
		jal strmix
		
		la a0, blendedword # print the blended word
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# print the first word
		la a0, newline # put address of newline into a0
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall
		la a0, firstwordstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedfirstword
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		# print the second word
		la a0, secondwordstr
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
		
		la a0, savedsecondword
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 

		
		# ask user if they want to continue
		la a0, continuestr # put address of continue_str into a0
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall 
				
		li a7, 12 # put value 12 into a7 to indicate readchar
		ecall # ecall to read a char from input console
		mv t3, a0 # store user char in t3
		cont_if: # label to indicate where the continue if statement starts
			li t6, 110 # load 110 into t6, which is the binary representation of the char 'n'
			beq t3, t6, end # branch to end if the user char is 'n'
			b bigwhile # branch to while if the user char is anything other than 'n'
			
	end: # label to indicate end of the program
		la a0, exitstr # put address of exit_str into a0
		li a7, 4 # put value 4 into a7 to indicate printstring
		ecall # ecall to print exit statement
		li a7, 10 # put value 10 into a7 to indicate exit
		ecall # ecall to exit program
	
.data
savedfirstword: .space 21 # allocate space for an array of chars that can be a maximum of 19 + nullchar + newline
savedsecondword: .space 26 # allocate space for an array of chars that can be a maximum of 24 + nullchar + newline
copiedword: .space 25 # allocate space for an array of chars that can be a maximum of 24 + nullchar
reversedword: .space 20 # allocate space for an array of chars that can be a maximum of 19 + nullchar
concatenatedword: .space 47
blendedword: .space 47

enterfirststr: .string "\nEnter first word: "
entersecondstr: .string "Enter second word: "
firstwordstr: .string "First word: "
secondwordstr: .string "\nSecond word: "
firstlengthstr: .string "\nLength of the first word: "
secondlengthstr: .string "\nLength of the second word: "
samestr: .string "The first and second words are the same."
diffstr: .string "The first and second words are NOT the same."
copystr: .string "\nThe new copied word is: "
revstr: .string "\nThe reversed word is: "
catstr: .string "\nThe concatenated word is: "
mixstr: .string "\nThe blended word is: "
continuestr: .string "\nContinue (y/n)?: "
exitstr: .string "\nExiting"
newline: .string "\n"