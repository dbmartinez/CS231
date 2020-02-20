# example of set greater than or equal command (sge). $s1 is assigned 20,$s2 is assigned 10.
# $a0 is going to get the  result of 1 since $s1 >= $s2. If you make them both equal, $a0 is   
# still 1. But if you place 12 in $s1 and 20 in $s2 the result of $a0 becomes 0 because 
# $s1 is not greater than or equal to $s2 	

.data

	str: .asciiz "the answer = "

.text
main:

	li $v0, 4
	la $a0, str
	syscall

	li $s1, 20		#load immediately $s1 with 20
	li $s2, 10		#load immediately $s2 with 10	

	sge $t0, $s1, $s2 	# $s1 > $s2 so $t0=1

	li $v0, 1		#print the value of $a0 which would be 1 in this case
	
	add $a0, $0, $t0	#print the value of $t0 which is  1 
	syscall

