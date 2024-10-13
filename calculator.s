# calculator.s
# Purpose: Arith operation calc, namely less than, plus, minus, and multiply on two parameters in assembly
# Name: Grantley
# Date: Feb 28th, 2024


	.globl	x_LessThan_y 
	.globl	plus
	.globl	minus
	.globl	mul


x_LessThan_y: # Description: is x less than y
						# %edi->x, %esi->y
	xorl	%eax, %eax	# set the return value (%eax) to 0 by clearing the register using XOR bitwise operation
	cmpl	%esi, %edi	# if the value of x (%edi) is less than the value of y (%esi), continue into the if statement to return 1 (%eax), otherwise do nothing and return 0 (%eax)
	setl	%al         # sets the value of return (%eax) to 1 if x is indeed less than y to represent true
	ret                 # return true (1) or false (0) (%eax)

plus: # Description: Performs integer addition
# Requirement:
						# %edi->x, %esi->y
	xorl	%eax, %eax	# set the return value (%eax) to 0 by clearing the register using XOR bitwise operation
	leal (%edi, %esi), %eax # add x (%edi) with y (%esi) and place the value in the return register (%eax)

	ret



minus: # Description: Performs integer subtraction
# Restrictions:
# - doesnt not use sub* instruction
# - doesnt not use loop
	
						# %edi->x, %esi->y
	xorl	%eax, %eax	# set the return value (%eax) to 0 by clearing the register using XOR bitwise operation
	negl %esi			# negate the value of y (%esi)
	addl %edi, %esi		# add x (%edi) with y (%esi), and store the result in the return register (%esi)
	movl %esi, %eax		# move the value of y (%esi) into the return register (%eax)
	ret


mul: # Description: Performs integer multiplication - when both operands are non-negative by adding y to a summing register starting at 0 x times

# algorithm:
#	clear return register (%eax)
#	set i(%edx) as 0 as a counter to count how many times to add y to the return value (%eax)
#	if i (%edx) is less than x (%edi), jump to loop
#	add y (%esi) to the return register (%eax)
#	add 1 to i (%edx) to show that one addition has been made to compute the product

						# %edi->x, %esi->y
	xorl	%eax, %eax	# set the return value (%eax) to 0 by clearing the register using XOR bitwise operation
	movl $0, %edx		# set i(%edx) as 0 as a counter to count how many times to add y to the return value (%eax)
	jmp test			# jump to the comparison section of the for loop, line 59
	loop:
		addl %esi, %eax	# add y (%esi) to the return register (%eax)
		addl $1, %edx	# add 1 to i (%edx)
	test:
		cmpl %edi, %edx # compare the value of i (%edx) with the value of x (%edi)
		jl loop			# if i(%edx) is less than x(%edi), continue the loop
	ret
