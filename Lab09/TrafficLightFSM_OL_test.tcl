# Test TrafficLightFSM_OL

# Procedure to run one test
proc doTest {CURRENT_STATE exp_LA exp_LB} {

	# Apply input test values
	set_value -radix bin CURRENT_STATE  $CURRENT_STATE

	# Run simulation
	run 10ns

	# Get output results
	set LA [get_value -radix bin LA]
	set LB [get_value -radix bin LB]
	
	# Compare to expected results
	upvar numTests numTests
	incr numTests
	upvar numErrors numErrors
	
	# If test fails, print message with details
	if {$LA != $exp_LA} {
		incr numErrors
		puts "Error!!  Inputs (CURRENT_STATE) = $CURRENT_STATE. Got LA = $LA, expected $exp_LA."
	}
	if {$LB != $exp_LB} {
		incr numErrors
		puts "Error!!  Inputs (CURRENT_STATE) = $CURRENT_STATE. Got LB = $LB, expected $exp_LB."
	}
}

# Initialize simulation
restart
set numErrors 0
set numTests 0
puts "\n***********************************\nRunning tests..."

# Run tests by calling doTest with test inputs and expected outputs
run 100ns

# doTest CURRENT_STATE exp_LA exp_LB
doTest        0000       100    100
doTest        0001       001    100
doTest        0010       010    100
doTest        0100       100    001
doTest        1000       100    010

# Print summary of results
puts "...done, found $numErrors error(s) in $numTests tests.\n***********************************"

