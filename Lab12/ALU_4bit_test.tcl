# Test ALU_4bit

# Procedure to run one test
proc doTest {A B F exp_Cout exp_Y} {

	# Apply input test values
	set_value -radix bin A $A
	set_value -radix bin B $B
	set_value -radix bin F $F

	# Run simulation
	run 10ns

	# Get output results
	set Cout [get_value -radix bin Cout]
	set Y [get_value -radix bin Y]
	
	# Compare to expected results
	upvar numTests numTests
	incr numTests
	upvar numErrors numErrors
	
	# If test fails, print message with details
	if {$Cout != $exp_Cout} {
		incr numErrors
		puts "Error!!  Inputs (A, B, F) = $A, $B, $F. Got Cout = $Cout, expected $exp_Cout."
	}
	if {$Y != $exp_Y} {
		incr numErrors
		puts "Error!!  Inputs (A, B, F) = $A, $B, $F. Got Y = $Y, expected $exp_Y."
	}
}

# Initialize simulation
restart
set numErrors 0
set numTests 0
puts "\n***********************************\nRunning tests..."

# Run tests by calling doTest with test inputs and expected outputs
run 100ns

# doTest     A    B    F exp_Cout exp_Y
doTest    0000 0000  000        0  0000
doTest    0000 0010  000        0  0000
doTest    0010 0000  000        0  0000
doTest    0010 0010  000        0  0010
doTest    0000 0000  000        0  0000
doTest    0000 1111  000        0  0000
doTest    1111 0000  000        0  0000
doTest    1111 1111  000        1  1111

doTest    0000 0000  001        0  0000
doTest    0000 0100  001        0  0100
doTest    0100 0000  001        0  0100
doTest    0100 0100  001        0  0100
doTest    0000 0000  001        0  0000
doTest    0000 1111  001        0  1111
doTest    1111 0000  001        0  1111
doTest    1111 1111  001        1  1111

doTest    0000 0000  010        0  0000
doTest    0000 0001  010        0  0001
doTest    0000 0111  010        0  0111
doTest    0000 1111  010        0  1111
doTest    0000 1000  010        0  1000
doTest    0001 0000  010        0  0001
doTest    0001 0001  010        0  0010
doTest    0001 0111  010        0  1000
doTest    0001 1111  010        1  0000
doTest    0001 1000  010        0  1001
doTest    0111 0000  010        0  0111
doTest    0111 0001  010        0  1000
doTest    0111 0111  010        0  1110
doTest    0111 1111  010        1  0110
doTest    0111 1000  010        0  1111
doTest    1111 0000  010        0  1111
doTest    1111 0001  010        1  0000
doTest    1111 0111  010        1  0110
doTest    1111 1111  010        1  1110
doTest    1111 1000  010        1  0111
doTest    1000 0000  010        0  1000
doTest    1000 0001  010        0  1001
doTest    1000 0111  010        0  1111
doTest    1000 1111  010        1  0111
doTest    1000 1000  010        1  0000

doTest    0000 0000  100        1  0000
doTest    0000 0100  100        0  0000
doTest    0100 0000  100        1  0100
doTest    0100 0100  100        1  0000
doTest    0000 0000  100        1  0000
doTest    0000 1111  100        0  0000
doTest    1111 0000  100        1  1111
doTest    1111 1111  100        1  0000

doTest    0000 0000  101        1  1111
doTest    0000 0100  101        0  1011
doTest    0100 0000  101        1  1111
doTest    0100 0100  101        1  1111
doTest    0000 0000  101        1  1111
doTest    0000 1111  101        0  0000
doTest    1111 0000  101        1  1111
doTest    1111 1111  101        1  1111

doTest    0000 0000  110        1  0000
doTest    0000 0001  110        0  1111
doTest    0000 0111  110        0  1001
doTest    0000 1111  110        0  0001
doTest    0000 1000  110        0  1000
doTest    0001 0000  110        1  0001
doTest    0001 0001  110        1  0000
doTest    0001 0111  110        0  1010
doTest    0001 1111  110        0  0010
doTest    0001 1000  110        0  1001
doTest    0111 0000  110        1  0111
doTest    0111 0001  110        1  0110
doTest    0111 0111  110        1  0000
doTest    0111 1111  110        0  1000
doTest    0111 1000  110        0  1111
doTest    1111 0000  110        1  1111
doTest    1111 0001  110        1  1110
doTest    1111 0111  110        1  1000
doTest    1111 1111  110        1  0000
doTest    1111 1000  110        1  0111
doTest    1000 0000  110        1  1000
doTest    1000 0001  110        1  0111
doTest    1000 0111  110        1  0001
doTest    1000 1111  110        0  1001
doTest    1000 1000  110        1  0000

# Print summary of results
puts "...done, found $numErrors error(s) in $numTests tests.\n***********************************"

