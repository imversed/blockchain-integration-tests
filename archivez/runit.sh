#!/bin/bash
. ~/imv-ecommerce-autotests/envnft.profile

#Defined total tests being run Pass\Fail
totalPass=0
totalFail=0

#method to run and check if test failed and passed
runTest () {
    runner=$(sh "$1")
    pass=$(echo "$runner" | grep -oh "\w*Passed\w*" | wc -l)
    fail=$(echo "$runner" | grep -oh "\w*Failed\w*" | wc -l)

    totalPass=$(($totalPass + $pass))
    totalFail=$(($totalFail + $fail))
    echo "Currently running test: $1"
    echo "$runner"
    }
#suite
runTest nftTest.sh
runTest oracleTest.sh
runTest updateTest.sh
runTest insuFeeTest.sh
runTest unauthorizedTest.sh
runTest lowFundsTest.sh
runTest transferFundsTest.sh

#test results
echo "==============="
echo "Tests Passed: $totalPass"
echo "==============="
echo "Tests Failed: $totalFail"
echo "==============="
echo "Total Stability: $(((100 * $totalPass)/($totalPass + $totalFail)))%"