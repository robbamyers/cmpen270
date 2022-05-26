# Test ALUSlice

# Procedure to run one test
proc doTest {A B F Cin exp_Cout exp_Y} {

	# Apply input test values
	set_value -radix bin A  $A
	set_value -radix bin B  $B
	set_value -radix bin F  $F
	set_value -radix bin Cin $Cin

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
		puts "Error!!  Inputs (A, B, F, Cin) = $A, $B, $F, $Cin. Got Cout = $Cout, expected $exp_Cout."
	}
	if {$Y != $exp_Y} {
		incr numErrors
		puts "Error!!  Inputs (A, B, F, Cin) = $A, $B, $F, $Cin. Got Y = $Y, expected $exp_Y."
	}
}

# Initialize simulation
restart
set numErrors 0
set numTests 0
puts "\n***********************************\nRunning tests..."

# Run tests by calling doTest with test inputs and expected outputs
run 100ns

# doTest A B   F Cin exp_Cout exp_Y
doTest   0 0 000   0        0     0
doTest   0 1 000   0        0     0
doTest   1 0 000   0        0     0
doTest   1 1 000   0        1     1
doTest   0 0 000   1        0     0
doTest   0 1 000   1        1     0
doTest   1 0 000   1        1     0
doTest   1 1 000   1        1     1

doTest   0 0 001   0        0     0
doTest   0 1 001   0        0     1
doTest   1 0 001   0        0     1
doTest   1 1 001   0        1     1
doTest   0 0 001   1        0     0
doTest   0 1 001   1        1     1
doTest   1 0 001   1        1     1
doTest   1 1 001   1        1     1

doTest   0 0 010   0        0     0
doTest   0 1 010   0        0     1
doTest   1 0 010   0        0     1
doTest   1 1 010   0        1     0
doTest   0 0 010   1        0     1
doTest   0 1 010   1        1     0
doTest   1 0 010   1        1     0
doTest   1 1 010   1        1     1

doTest   0 0 100   0        0     0
doTest   0 1 100   0        0     0
doTest   1 0 100   0        1     1
doTest   1 1 100   0        0     0
doTest   0 0 100   1        1     0
doTest   0 1 100   1        0     0
doTest   1 0 100   1        1     1
doTest   1 1 100   1        1     0

doTest   0 0 101   0        0     1
doTest   0 1 101   0        0     0
doTest   1 0 101   0        1     1
doTest   1 1 101   0        0     1
doTest   0 0 101   1        1     1
doTest   0 1 101   1        0     0
doTest   1 0 101   1        1     1
doTest   1 1 101   1        1     1

doTest   0 0 110   0        0     1
doTest   0 1 110   0        0     0
doTest   1 0 110   0        1     0
doTest   1 1 110   0        0     1
doTest   0 0 110   1        1     0
doTest   0 1 110   1        0     1
doTest   1 0 110   1        1     1
doTest   1 1 110   1        1     0

# Print summary of results
puts "...done, found $numErrors error(s) in $numTests tests.\n***********************************"

