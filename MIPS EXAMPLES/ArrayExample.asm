.data
	str1: .asciiz "Enter a number: "
	str2: .asciiz "\nThe result is: "

	num1: .word 0      # creating a space called num1 and initializing to 0
	num2: .word 0      # creating a space called num2 and initializing to 0

	sum: .word 0      # creating a space called sum  and initializing to 0

.text

main:
	li $v0, 4		# ask user for number
	la $a0, str1
	syscall

	li $v0, 5 	        # read the first number                 
	syscall

	sw $v0, num1        	# store the first number into memory location num1
	
	li $v0, 4		# ask user for number
	la $a0, str1
	syscall

	li $v0, 5           	# read the second number
	syscall

	sw $v0, num2       	# store the first number into memory location num2

	lw $t0, num1       	# take the numbers out of memory location num1 and 
	lw $t1, num2       	# num 2and load them in to registers $to and $t1

	add $t3, $t0, $t1      	# do addition on them 

	sw $t3, sum             # store the result back to memory

	li $v0, 4	
	la $a0, str2            # print the result is
	syscall

	lw $a0, sum            # in order to print the result ,load the result value 
	li $v0, 1               
	syscall		       # from memory location sum to $a0
	
	li $v0, 10
	syscall
	
