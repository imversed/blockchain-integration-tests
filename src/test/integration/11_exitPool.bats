#!/usr/bin/env bats
@test "Exit Pool" {
  #Check LP
  checkPool=$(imversed q pools pool 1 | sed '12!d' | sed 's/amount: //g')
  #Check users balance
  checkBalance=$(imversed q bank balances imv1v4kuj7f4cwh3hum8vxqjd824j0jrwjv5fvyda8 | grep -o 'amount:.*' | sed 's/amount: //g; s/"//g')
  echo "$checkBalance" >&3
  #Exit the LP
  sleep 6
  exitPool=$(yes | imversed tx pools exit-pool --min-amounts-out=1aimv \
  --min-amounts-out=1montanatoken --pool-id=1 --share-amount-in=100000000000000000000 \
  --from=imv1v4kuj7f4cwh3hum8vxqjd824j0jrwjv5fvyda8 | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  #Verify exit
  isExit=$(imversed q tx "$exitPool" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$isExit" == "code: 0" ]
  sleep 6
  #Check shares decreased
  checkExpectedPool=$(imversed q pools pool 1 | sed '12!d' | sed 's/amount: //g')
  #Verify decrease
  [[ "$checkPool" != "$checkExpectedPool" ]]
  #Verify users balance
  sleep 6
  expectedBalance=$(imversed q bank balances imv1v4kuj7f4cwh3hum8vxqjd824j0jrwjv5fvyda8 | grep -o 'amount:.*' | sed 's/amount: //g; s/"//g')
  echo "$expectedBalance" >&3
  [[ "$checkBalance" != "$expectedBalance" ]]
}