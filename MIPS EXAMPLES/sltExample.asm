# example of set less than (slt).  $s1 is assigned 10, $s2 is assigned 20. 
# $a0 is going to get the result of 1 since $s1 < $s2. If this is not the case,
# $a0 becomes 0


.data
	str: .asciiz "the answer = "

.text
main:
	li $v0, 4
	la $a0, str
	syscall

	li $s1, 10			#load $s1 with value of 10
	li $s2, 20			#load $s2 with the value of 20
	
	slt $t0, $s1, $s2		# $s1 < $s2 so $t0=1

	li $v0, 1
	add $a0, $t0, $0		#print the value of $t0 which is  1 
	syscall				#since $s1<$s2 in this case
