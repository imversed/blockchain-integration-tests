#!/bin/bash

sh test/core/nftTest.sh

echo "Next test."

sh test/core/oracleTest.sh

echo "Next test."

sh test/core/unauthorizedTest.sh

echo "Next test."

sh test/core/insuFeeTest.sh

echo "Next test."

sh test/core/lowFundsTest.sh

echo "Next test."

sh test/core/updateTest.sh