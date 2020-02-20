.data
	items: .space 20
	coupon: .space 20
	
	str: .asciiz "\nPlease enter the number of item you are purchasing(should be less than or equal to 20): "
	
	error1:	.asciiz	"\nSorry too many items to purchase!! Please enter number of items you are purchasing: "
	error2:	.asciiz "\nSorry too few items to purchase!! Please enter number of items you are purchasing: "
	error3:	.asciiz	"\nToo many Coupons!! Please re-enter below..\n"
	error4:	.asciiz	"\nError: This coupon is not acceptable!\n"
	
	coupons1: .asciiz "\nCOUPONS!!!!!"
	coupons2: .asciiz "\n------------"
	
	enter1:	.asciiz	"\nPlease enter the price of item "
	enter2:	.asciiz	"\nPlease enter the number of coupons that you want to use: "
	enter3:	.asciiz "\nPlease enter the amount of coupon "
	
	totalCost: .asciiz "\nYour total charge is:\t$"
	thankYou: .asciiz "\n\n\nThank you for shopping with us, have a great day."
	colon:	.asciiz	": $"	
	
	newLine: .asciiz "\n"

.text

main:	

	li $v0, 4
	la $a0, str			# Display prompt to user
	syscall

	li $v0, 5			# Get user input
	syscall

	add $s0, $v0, $0		# Store $v0, to #s0
	li $s1, 20			# Hardcode 20 to $s1

	bgt $s0, $s1, error2ManyItems	# Too mant items go to error
	ble $s0, $0, error2LowItems	# Too few items go to error

	add $a0, $s0, $0
	jal fillPriceArray		# Jump and link to fillPriceArray

	add $s3, $v0, $0		# Price of the objects

couponNumber:

	li $v0, 4
	la $a0, coupons1		# Display COUPON!!
	syscall
	
	li $v0, 4
	la $a0, coupons2		# Display ------
	syscall
	
	li $v0, 4
	la $a0, enter2			# Display prompt for coupons
	syscall

	li $v0, 5			# Get user input for coupons
	syscall

	add $s2, $v0, $0		# Store $v0 to $s2
	
	blt $s2, $s0, couponError	# error is larger than amount of items

	add $a0, $s2, $0		# Store $s2 to #a0
	
	jal fillCouponArray		# Jump and link to fillCouponArray
	
	add $s4, $v0, $0		# Price of discounts
	sub $s3, $s3, $s4		# Subtract coupons from items

	li $v0, 4
	la $a0, totalCost		# Display message total cost
	syscall

	li $v0, 1			# Load integer for display
	add $a0, $s3, $0		# Display total cost
	syscall

	li $v0, 4
	la $a0, thankYou		# Display Thank you message
	syscall
	
	li $v0, 4
	la $a0, newLine			# Add a new line
	syscall

	li $v0, 10			# Exit program
	syscall

fillPriceArray:	

	add $t0, $a0, $0		# Load the arguement (# of items) to $t0
	la $t1, items			# Load the array address
	li $t2, 0			# Load the counter 0
	li $t3, 0			# Load the accumulator 0

	fillLoop:	
	
		beq $t0, $t2, loopExit  # If equal to 0 exit loop
		
		li $v0, 4		
		la $a0, enter1		# User enters price of item
		syscall

		li $v0, 1		
		add $a0, $t2, 1		# Print number + 1
		syscall

		li $v0, 4		# print string
		la $a0, colon		# print colon
		syscall

		li $v0, 5		# User input
		syscall
		
		sw $v0, 0($t1)		# Store the int into the array

		add $t3, $t3, $v0	# Add to the accumulator

		add $t1, $t1, 4		# Add 4 to the address
		add $t2, $t2, 1		# Add 1 to the counter

		j fillLoop		# Jump back to fillLoop
	
loopExit:	

	add $v0, $t3, $0
	jr $ra				# Return adrress

fillCouponArray:	

	add $t0, $a0, $0		# Amount of coupons
	
	la $t1, coupon			# array address for coupons
	li $t2, 0			# counter
	li $t3, 0			# accumulator
	la $t4, items			# items array address
	li $t6, 9

fillCoupon:	
	
	beq $t2, $t0, loop2Exit		# If equal go to loop2Exit

	li $v0, 4			
	la $a0, enter3			# Display prompt to user(enter amount of coupon)
	syscall

	li $v0, 1			# Load integer
	add $a0, $t2, 1			# Print counter + 1
	syscall

	li $v0, 4			
	la $a0, colon			# Display the colon (:)
	syscall

	li $v0, 5			# User inputs amount of coupons
	syscall

	lw $t7, 0($t4)			# Load $t4(array) to $t7
	add $t5, $v0, $0		# Store $v0 to $t5

	bgt $t5, $t7, invalidCoupon	# If greater than (item array) go to error(invalidCoupon)
	bgt $t5, $t6, invalidCoupon	# If greater than 9 go to error(invalidCoupon)

	sw $t5, 0($t1)			# Store the int into the array
	add $t3, $t3, $t5		# Add to the accumulator 

	add $t1, $t1, 4			# Add 4 to the address (items)
	add $t4, $t4, 4			# Add 4 to the address (coupons)
	add $t2, $t2, 1			# Add 1 to the counter

	j fillCoupon			# Jump back to fillCoupon

loop2Exit:	

	add $v0, $t3, $0		# Store $t3 to $v0
	jr $ra				# Return address to main

invalidCoupon:	

	li $v0, 4
	la $a0, error4			# Display if coupon is not acceptable
	syscall
		
	sw $0, 0($t1)			# Store the int into the array
	add $t1, $t1, 4			# Add 4 to the address (items)
	add $t4, $t4, 4			# Add 4 to the address (coupons)
	add $t2, $t2, 1			# Add 1 to the counter

	j fillCoupon			# Jump back to fillCoupon

error2ManyItems:	

	li $v0, 4		
	la $a0, error1			# Display error if too many items
	syscall

	j main				# Jump back to main

error2LowItems:	
	
	li $v0, 4		
	la $a0, error2			# Display error if not enough items
	syscall

	j main				# Jump back to main

couponError:	

	li $v0, 4
	la $a0, error3			# Display error if too much coupons
	syscall
	
	j couponNumber			# Jump back to couponNumber
