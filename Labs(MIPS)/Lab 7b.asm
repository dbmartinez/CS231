.data
	str: .asciiz "\nPlease enter the message you want sent: \n\n"
	
	newLine: .asciiz "\n"

	input: .byte '_','_','_','_','_','_','_','_','_','_'
	str1: .asciiz "\nYour encrypted message is: "
	str2: .asciiz "\nYour decrypted message is: "
	copy: .byte '_','_','_','_','_','_','_','_','_','_'

.text
main:
	
	li $v0, 4
	la $a0, str			# Display first prompt
	syscall

	li $s0, 10			# Key is 10
	li $v0, 8			# Read string
	li $a1, 10			# Read number of characters 9, 10th null terminator
	la $a0, input			# Address of array
	syscall
	
	add $t0, $a1, $0		# Store $a1 to $t0
	
	la $s1, input			# Store input array to $s1
	la $s2, copy			# Store copy array to $s2

loop:
	beq $t0, $0, done		# If $t0 is equal to zero go to done
	
	li $t1, 0			# Set to zero counter
	
	lb $t1, 0($s1)			# Load byte to $t1
	xor $t1, $t1, $s1		# Encrypt the message
	sb $t1, 0($s2)			# Store byte to $t1
	
	addi $s1, $s1, 1		# Counter by 1 byte
	addi $s2, $s2, 1                # Counter by 1 byte
	addi $t0, $t0, -1		# Decrement by 1 byte

	j loop				# Jump back to loop

done:

	li $v0, 4
	la $a0, newLine			# New line
	syscall

	li $v0, 4
	la $a0, str1			# Display encrypted prompt
	syscall
	
	li $v0,4	
	la $a0, copy			# Display encrypted result
	syscall
	
	li $v0, 4
	la $a0, str2			# Display decrypted prompt
	syscall
	
	li $v0, 4
	la $a0, input			# Display decrypted result
	syscall
	
	li $v0, 4
	la $a0, newLine			# New line
	syscall

	li $v0, 10			# Exit prgram
	syscall