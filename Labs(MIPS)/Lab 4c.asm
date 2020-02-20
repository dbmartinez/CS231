.data
	# Lab 4(Description/Author/Date)
	str: .asciiz "Program Description:\tThis prggram is dealing with factorials\n"
	str1: .asciiz "Author:\t\t\tDaniel Martinez\n"
	str2: .asciiz "Creation Date:\t\t09/14/2018\n\n\n"
	
	# Title
	header: .asciiz "\t\t\tFactorials\n"
	header1: .asciiz "\t\t\t_________\n\n"
	
	str3: .asciiz "\nEnter in a number between 0 and 10: "
	str4: .asciiz "\nThe factorial is "
	newline: .asciiz ".\n"
	zero1: .asciiz "\nThe factorial is 1.\n"
	error0: .asciiz "\n---> Error: Not in the range between 0 - 10.\n"

.text
	li $v0, 4		# Display prompt
	la $a0, str
	syscall

	la $a0, str1		# Display author
	syscall
	
	la $a0, str2		# Display date
	syscall
	
	la $a0, header		# Title
	syscall
	
	la $a0, header1	
	syscall

main:
	li $s0, 0		# Hard-code 0
	li $s1, 1		# Hard-code 1
	li $s2, 10		# Hard-code 10
	
	la $a0, str3		# Ask user input
	syscall
	
	li $v0, 5		# User input
	syscall
	
	add $s3, $v0, $0	# Store $v0 to $s3
	
	blt $s3, $s0, error	# Check to see if input is less than 0
	beq $s3, $s0, zero
	bgt $s3, $s2, error	# Check to see if input is greater than 10
	
	add $s4, $s3, $0	# Copy input
	
multiply:
	addi $s4, $s4, -1	# Decrement by 1 for factorial
		
	beq $s4, $s0, done
	
	mult $s3, $s4		# Multiplication of the factorial
	
	mflo $s3
	
	j multiply		# Jump back
	
done:
	li $v0, 4		# Display prompt for factorial
	la $a0, str4
	syscall
	
	li $v0, 1		# Display final result
	add $s5, $s3, $s5
	add $a0, $s5, $0
	syscall
	
	li $v0, 4		# newline(\n)
	la $a0, newline
	syscall
	
	li $v0, 10		# Exit program
	syscall
	
zero:
	li $v0, 4		# If equal to zero
	la $a0, zero1
	syscall
	
	li $v0, 10		# Exit program
	syscall
	
error:
	li $v0, 4		# Display error message if not in range
	la $a0, error0
	syscall
	
	j main 
