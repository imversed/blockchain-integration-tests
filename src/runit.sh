#!/bin/bash

totalPass=0
totalFail=0

runTest () {
    peremen=$(sh "$1")
    pass=$(echo "$peremen" | grep -oh "\w*Passed\w*" | wc -l)
    fail=$(echo "$peremen" | grep -oh "\w*Failed\w*" | wc -l)

    totalPass=$(($totalPass + $pass))
    totalFail=$(($totalFail + $fail))
    echo "Current running test: $1"
    echo "$peremen"
    }


runTest test/core/nftTest.sh
runTest test/core/oracleTest.sh
runTest test/core/updateTest.sh
runTest test/core/insuFeeTest.sh
runTest test/core/unauthorizedTest.sh
runTest test/core/lowFundsTest.sh

echo "==============="
echo "Tests Passed: $totalPass"
echo "==============="
echo "Tests Failed: $totalFail"
echo "==============="
echo "Total Stability: $(((100 * $totalPass)/($totalPass + $totalFail)))%"