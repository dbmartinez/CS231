# example of less than or equal (sle) $s1 is assigned 10, $s2 is assigned 20. $a1 is  
# going to get the result of 1 since $s1 <= $s2. If this is not the case $a0 becomes 0

.data

	str: .asciiz "the answer = "

.text
main:
	li $v0, 4
	la $a0, str
	syscall

	li $s1, 10
	li $s2, 20

	sle $t0, $s1, $s2

	li $v0, 1
	add $a0, $t0, $0
	syscall

