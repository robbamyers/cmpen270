# Test TrafficLightFSM

# Initialization
proc doInit {} {
	set_value -radix bin PULSE 0
	set_value -radix bin RESET 1
	set_value -radix bin CLK   0
	run 10ns
	set_value -radix bin PULSE 0
	set_value -radix bin RESET 1
	set_value -radix bin CLK   1
	run 10ns
	set_value -radix bin PULSE 0
	set_value -radix bin RESET 1
	set_value -radix bin CLK   0
	run 5ns
}

# Procedure to run one test (test cycles the clock on-off, assumes CLK=0 when proc is called)
proc doTest {TA TB PULSE RESET exp_LA exp_LB} {

	# Apply input test values
	set_value -radix bin TA    $TA
	set_value -radix bin TB    $TB
	set_value -radix bin PULSE $PULSE
	set_value -radix bin RESET $RESET

	# Run simulation
	run 5ns
	set_value -radix bin CLK 1
	run 10ns
	set_value -radix bin CLK 0
	run 5ns

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
		puts "Error!!  Inputs (TA TB PULSE RESET) = $TA, $TB, $PULSE, $RESET. Got LA = $LA, expected $exp_LA."
	}
	if {$LB != $exp_LB} {
		incr numErrors
		puts "Error!!  Inputs (TA TB PULSE RESET) = $TA, $TB, $PULSE, $RESET. Got LB = $LB, expected $exp_LB."
	}
}

# Initialize simulation
restart
set numErrors 0
set numTests 0
puts "\n***********************************\nRunning tests..."

# Run tests by calling doTest with test inputs and expected outputs
run 100ns
doInit

# doTest TA TB PULSE RESET exp_LA exp_LB

# Reset, both lights red
doTest    0  0   0     1     100    100
doTest    0  0   0     0     100    100
doTest    0  0   0     0     100    100

#TA=0, TB=0: S0, A green, B red
doTest    0  0   1     0     001    100
doTest    0  0   0     0     001    100
doTest    0  0   0     0     001    100

#TA=0, TB=0: S1, A yellow, B red
doTest    0  0   1     0     010    100
doTest    0  0   0     0     010    100
doTest    0  0   0     0     010    100

#TA=0, TB=0: S2, A red, B green
doTest    0  0   1     0     100    001
doTest    0  0   0     0     100    001
doTest    0  0   0     0     100    001

#TA=0, TB=0: S3, A red, B yellow
doTest    0  0   1     0     100    010
doTest    0  0   0     0     100    010
doTest    0  0   0     0     100    010

#TA=0, TB=0: S0, A green, B red
doTest    0  0   1     0     001    100
doTest    0  0   0     0     001    100
doTest    1  0   0     0     001    100

#TA=1, TB=0: S0, A green, B red
doTest    1  0   1     0     001    100
doTest    1  0   0     0     001    100
doTest    1  1   0     0     001    100

#TA=1, TB=1: S0, A green, B red
doTest    1  1   1     0     001    100
doTest    1  1   0     0     001    100
doTest    0  1   0     0     001    100

#TA=0, TB=1: S1, A yellow, B red
doTest    0  1   1     0     010    100
doTest    0  1   0     0     010    100
doTest    0  1   0     0     010    100

#TA=0, TB=1: S2, A red, B green
doTest    0  1   1     0     100    001
doTest    0  1   0     0     100    001
doTest    0  1   0     0     100    001

#TA=0, TB=1: S2, A red, B green
doTest    0  1   1     0     100    001
doTest    0  1   0     0     100    001
doTest    1  1   0     0     100    001

#TA=1, TB=1: S2, A red, B green
doTest    1  1   1     0     100    001
doTest    1  1   0     0     100    001
doTest    1  0   0     0     100    001

#TA=1, TB=0: S3, A red, B yellow
doTest    1  0   1     0     100    010
doTest    1  0   0     0     100    010
doTest    0  1   0     0     100    010

#TA=0, TB=1: S0, A green, B red
doTest    0  1   1     0     001    100
doTest    0  1   0     0     001    100
doTest    1  1   0     0     001    100

# Print summary of results
puts "...done, found $numErrors error(s) in $numTests tests.\n***********************************"

