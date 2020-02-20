.data
	# Lab 4(Description/Author/Date)
	str1: .asciiz "Program Description:\tThis program is dealing with decision making and loops\n"
	str2: .asciiz "Author:\t\t\tDaniel Martinez\n"
	str3: .asciiz "Creation Date:\t\t09/12/2018\n\n\n"
	
	# Title
	header: .asciiz "\t\t\tDecision and Loops\n"
	header1: .asciiz "\t\t\t__________________\n\n"
	
	# User input
	input: .asciiz "How many positive numbers that is divisible by 6 you want to add? \n"
	
	# Loop output
	output: .asciiz "\nEnter a number:\n"
	output1: .asciiz "\nThis number is divisible by 6\n"
	
	# Sum
	sum: .asciiz "\nThe sum of all positive integers is "
	
	# Error message
	error0: .asciiz "\n==> **** ERROR: Not in the range of 1 to 100. Enter another number.\n"
	error: .asciiz "\n==> Not divisible by 6. Enter another number.\n"

.text

main:
	li $v0, 4			# Author info
	la $a0, str1
	syscall
	
	la $a0, str2
	syscall

	la $a0, str3
	syscall
	
	la $a0, header			# Title(Decision and Loops)
	syscall
	
	la $a0, header1
	syscall
	
	li $s1, 0
	
	la $a0, input  			# Ask for user input
	syscall
	
	li $v0, 5                    	# User input
	syscall
	
	add $s0, $v0, $0		# Store $v0 to $s0
	
loop:
	beq $s1, $s0, done		# loop(input $s0 to loop)
	
	li $s7, 6			# Hard-coded integers
	li $t0, 1
	li $t1, 100
	
	li $v0, 4			# Display prompt
	la $a0, output
	syscall
	
	li $v0, 5			# User enters integer
	syscall
	
	add $s3, $v0, $0		# Store $v0 to $s3
	
	ble $s3, $t0, error1		# Check to see if input is less than 1
	bge $s3, $t1, error1		# Check to see if input is greater than 100
	
	div $s3, $s7			# Input divide by 6
	
	li $v0, 4 			# Output if it is divisible by 6
	la $a0, output1
	syscall
	
	mfhi $t2			# Remainder
	mflo $t3			# Quotient
	
	bne $t2, $0, error2		# Check hi is zero go to error 2
									
	add $s4, $s3, $s4		# Add number to sum
	addi $s1, $s1, 1		# Counter
	
	j loop
	
done:
	li $v0, 4			# Sum Prompt
	la $a0, sum
	syscall
						
	li $v0, 1			# Output sum
	add $a0, $s4, $0
	syscall
	
	li $v0, 10			# Exit program
	syscall
	
error1:
	li $v0, 4			# Load if error not in range
	la $a0, error0 	
	syscall
	
	j loop

error2:
	li $v0, 4			# Load if error not divisible by 6
	la $a0, error
	syscall
	
	j loop
