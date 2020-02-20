# Author: Daniel Martinez
# Due Date: 09/26/2018
# Prof: S. Mosleh

.data
	str: .asciiz "\n\nInput a number in decimal form: "
	str1: .asciiz "\nThe value entered in binary is: "
	
	newLine: .asciiz "\n"

.text

main:	

	li $v0, 4
	la $a0, str			# Display prompt to user
	syscall

	li $v0, 5			# User input	
	syscall	

	add $a0, $v0, $0		# Store $v0 to $a0
	
	jal binary			# Go to binary
	
	li $v0, 4
	la $a0, newLine			# Newline after displaying binary
	syscall

	li $v0, 10			# Exit Program
	syscall

binary:

	li $s1, 32			# Hardocode 32 for max
	li $s2, 0			# Hardcode to 0
	li $s3, 2			# Hardcode 2 for division
	
	add $t1, $a0, $0		# Store $ao to $t1

loop:	

	beq $t1, $0, bits32		# If equal to 0 go to bits32
	
	div $t1, $s3			# divide user input by 2
	
	mfhi $t0			# Remainder
	mflo $t1			# Quotient

	addi $sp, $sp, -4		# Decrement by 4
	
	sw $t0, 0($sp)			# Push

	addi $s2, $s2, 1		# Increment 1

	j loop				# Jump back to loop

bits32:	

	sub $t2, $s1, $s2		# Amount of 0's
	li $s4, 0

	li $v0, 4
	la $a0, str1			# Display final prompt to user
	syscall
	
	li $v0, 4
	la $a0, newLine			# New line(\n)
	syscall
	
zeroloop:	

	beq $s4, $t2, IneedZeros	# If equal go to IneedZeros
	
	li $v0, 1
	li $a0, 0			# Display the zeros
	syscall

	addi $s4, $s4, 1		# Increment 1

	j zeroloop

IneedZeros:	

	li $s4, 0			# Hardcode to 0
	
loop2:	

	beq $s4, $s2, exit		# If equal to 0 go to exit
	
	li $v0, 1
	lw $a0, 0($sp)			# Display zeros
	syscall

	addi $sp, $sp, 4		# Increment stack pointer by 4 bytes
	addi $s4, $s4, 1		# Increment by 1

	j loop2				# Jump back to loop2 

exit:	

	jr $ra				# Return(address) to main
