.data

	Array: .word 0,0,0,0,0,0,0,0,0,0

	str0: .asciiz "\nHow many numbers would you like to add: "
	str1: .asciiz "\nEnter number: "
	str2: .asciiz "\nThe median is: "

	content0: .asciiz "===========================================\n"
	content1: .asciiz "\n==========================================="
	content2: .asciiz "\n===========================================\n"

	error0: .asciiz "\nError--- Must be between 1 and 10: \n"

.text

main:

	la $s0, Array 		# Load $s0 to array
	add $t6, $s0, $0 	# storing the array address

	li $v0, 4 		# Display prompt for user input
	la $a0, str0 		# Load the string str
	syscall

	li $v0, 5 		# User input
	syscall

	add $s1, $v0, $0 	# store $v0 to $s0

	li $t0, 0 		# Hard code to 0
	li $t1, 11 		# Hard code to 11

	ble $s1, $t0, error 	# Check to see if input is less than 0
	bge $s1, $t1, error 	# Check to see if input is greater than 11

	li $v0, 4 		# ========================
	la $a0, content0
	syscall

loop:

	beq $t0, $s1, calculate # User input equals 0s

	li $v0, 4 		# Display prompt for user input
	la $a0, str1 		# Load the string str1
	syscall

	li $v0, 5 		# User input
	syscall

	sw $v0, 0($s0) 		# Address of first element in the array

	addi $t0, $t0, 1 	# increment by 1
	addi $s0, $s0, 4 	# Add 4 to the next section
	
	j loop 			# Jump to output

calculate:

	li $t5, 2

	div $s1, $t5 		# divide by 2

	mfhi $t3 		# Remainder
	mflo $t4 		# Quotient

	li $t5, 4 		# Hard code to 4

	mult $t4, $t5 		# multiply $lo by 4
	mflo $t4

	add $s0,$t6,$t4 	# address of median

	bne $t3,1,even 		# when remainder is 0 skip to even

odd:

	lw $t7, 0($s0)

	j output

even:

	lw $t7, 0($s0)

	lw $t8, -4($s0)

	add $t7,$t7,$t8

	mtc1 $t7,$f1

	li $t5,2

	mtc1 $t5, $f2

	div.s $f1, $f1, $f2

	j output

output:

	li $v0, 4 		# ==================
	la $a0, content1
	syscall

	la $a0, str2		# Load string str2/ Display prompt
	syscall

	bne $t3, 1, float	# when remainder is 0 print a float

	li $v0, 1 		# Load integer
	add $a0, $t7, $0	# Display integer
	syscall

	j skip

float:

	li $v0, 2 		# Load integer
	mov.s $f12, $f1 	# Display float
	syscall

skip:

	li $v0, 4 		# ==================
	la $a0, content2
	syscall

	j exit 			# Jump to exit

error:

	li $v0, 4 		# Display error message
	la $a0, error0 		# if not between 0 and 11
	syscall

	j main 			# Jump back to main program

exit:

	li $v0, 10 		# Terminate program
	syscall
