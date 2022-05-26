# Test TrafficLightFSM_NSL

# Procedure to run one test
proc doTest {CURRENT_STATE TA TB exp_NEXT_STATE} {

	# Apply input test values
	set_value -radix bin CURRENT_STATE  $CURRENT_STATE
	set_value -radix bin TA             $TA
	set_value -radix bin TB             $TB

	# Run simulation
	run 10ns

	# Get output results
	set NEXT_STATE [get_value -radix bin NEXT_STATE]
	
	# Compare to expected results
	upvar numTests numTests
	incr numTests
	upvar numErrors numErrors
	
	# If test fails, print message with details
	if {$NEXT_STATE != $exp_NEXT_STATE} {
		incr numErrors
		puts "Error!!  Inputs (CURRENT_STATE, TA, TB) = $CURRENT_STATE, $TA, $TB. Got NEXT_STATE = $NEXT_STATE, expected $exp_NEXT_STATE."
	}
}

# Initialize simulation
restart
set numErrors 0
set numTests 0
puts "\n***********************************\nRunning tests..."

# Run tests by calling doTest with test inputs and expected outputs
run 100ns

# doTest CURRENT_STATE TA TB exp_NEXT_STATE
doTest        0000      0  0      0001
doTest        0000      0  1      0001
doTest        0000      1  0      0001
doTest        0000      1  1      0001

doTest        0001      0  0      0010
doTest        0001      0  1      0010
doTest        0001      1  0      0001
doTest        0001      1  1      0001

doTest        0010      0  0      0100
doTest        0010      0  1      0100
doTest        0010      1  0      0100
doTest        0010      1  1      0100

doTest        0100      0  0      1000
doTest        0100      0  1      0100
doTest        0100      1  0      1000
doTest        0100      1  1      0100

doTest        1000      0  0      0001
doTest        1000      0  1      0001
doTest        1000      1  0      0001
doTest        1000      1  1      0001

# Print summary of results
puts "...done, found $numErrors error(s) in $numTests tests.\n***********************************"

