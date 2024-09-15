#Name: Megan Robinson
.global main
.text # text directive that defines where the program instructions go
main:
	jal initialization
	li a0, '*'
loop:
	jal printChar
	b loop