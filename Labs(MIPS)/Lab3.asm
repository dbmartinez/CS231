.data
	# Lab 3(Description/Author/Date)
	str1: .asciiz "Program Description:\tThis program is written to mimic a very basic calculator \n"
	str2: .asciiz "Author:\t\t\tDaniel Martinez\n"
	str3: .asciiz "Creation Date:\t\t09/10/2018\n\n\n"
	
	# Fun With MIPS!!!!!!!
	fun: .asciiz "\t\tJust a basic calculator\n"
	fun1: .asciiz "\t\t_______________________\n\n"
	
	# Have user input 2 numbers to be calculated 
	userInput: .asciiz "Please input two numbers:\n"
	
	# Calculated Results
	sum: .asciiz "\nSum is:\t\t"
	difference: .asciiz "\nDifference is:\t"
	product: .asciiz "\nProduct is:\t"
	quotient: .asciiz "\nQuotient is:\t"
	remainder: .asciiz "\nRemainder is:\t"
	extraStuff: .asciiz "\n"
	
.text
main:
	# Display Header Information
	li $v0, 4
	la $a0, str1
	syscall
	
	la $a0 str2
	syscall
	
	la $a0 str3
	syscall
	
	# Fun header
	la $a0 fun
	syscall
	
	la $a0 fun1
	syscall
	
	# User Inputs two integers
	la $a0 userInput
	syscall
	
	li $v0, 5
	syscall
	
	# Store $v0 to $t0 (first integer)
	add $t0, $0, $v0
	
	li $v0, 5
	syscall
	
	# Store $v0 to $t1 (second integer)
	add $t1, $0, $v0
	
	# Display Calculated Results
	# Sum
	li $v0, 4
	la $a0 sum
	syscall
	
	add $a0, $t1, $t0
	
	li $v0, 1
	syscall
	
	# Difference
	li $v0, 4
	la $a0 difference
	syscall
	
	sub $a0, $t0, $t1
	
	li $v0, 1
	syscall
	
	# Product
	li $v0, 4
	la $a0 product
	syscall
	
	mult $t0, $t1
	
	mfhi $s0 
 	mflo $s1 
	
	li $v0, 1
	add $a0, $s1, $0
	syscall
	
	# Quotient
	li $v0, 4
	la $a0 quotient
	syscall
	
	div $t0, $t1
	
	mfhi $s0 
 	mflo $s1 
	
	li $v0, 1
	add $a0, $s1, $0
	syscall
	
	# Remainder
	li $v0, 4
	la $a0 remainder
	syscall
	
	li $v0, 1
	add $a0, $s0, $0
	syscall
	
	li $v0, 4
	la $a0 extraStuff
	syscall
	
	# Terminate Program
	li $v0, 10
	syscall

