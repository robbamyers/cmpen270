# Test CompareEQU_8bit

# Procedure to run one test
proc doTest {A B exp_EQU} {

	# Apply input test values
	set_value -radix bin A $A
	set_value -radix bin B $B

	# Run simulation
	run 10ns

	# Get output results
	set EQU [get_value -radix bin EQU]
	
	# Compare to expected results
	upvar numTests numTests
	incr numTests
	upvar numErrors numErrors
	
	# If test fails, print message with details
	if {$EQU != $exp_EQU} {
		incr numErrors
		puts "Error!!  Inputs (A, B) = $A, $B. Got EQU = $EQU, expected $exp_EQU."
	}
}

# Initialize simulation
restart
set numErrors 0
set numTests 0
puts "\n***********************************\nRunning tests..."

# Run tests by calling doTest with test inputs and expected outputs
run 100ns

# doTest         A        B  exp_EQU
doTest    00000000 00000000        1
doTest    00000000 00000001        0
doTest    00000001 00000000        0
doTest    00000001 00000001        1

doTest    00000000 00000000        1
doTest    00000000 00000010        0
doTest    00000010 00000000        0
doTest    00000010 00000010        1

doTest    00000000 00000000        1
doTest    00000000 00000100        0
doTest    00000100 00000000        0
doTest    00000100 00000100        1

doTest    00000000 00000000        1
doTest    00000000 00001000        0
doTest    00001000 00000000        0
doTest    00001000 00001000        1

doTest    00000000 00000000        1
doTest    00000000 00010000        0
doTest    00010000 00000000        0
doTest    00010000 00010000        1

doTest    00000000 00000000        1
doTest    00000000 00100000        0
doTest    00100000 00000000        0
doTest    00100000 00100000        1

doTest    00000000 00000000        1
doTest    00000000 01000000        0
doTest    01000000 00000000        0
doTest    01000000 01000000        1

doTest    00000000 00000000        1
doTest    00000000 10000000        0
doTest    10000000 00000000        0
doTest    10000000 10000000        1

doTest    00000000 00000000        1
doTest    00000000 11111111        0
doTest    11111111 00000000        0
doTest    11111111 11111111        1


# Print summary of results
puts "...done, found $numErrors error(s) in $numTests tests.\n***********************************"

