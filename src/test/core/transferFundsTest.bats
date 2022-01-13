#!/usr/local/bin/bats
load ~/imv-ecommerce-autotests/envnft.profile


@test "transfer funds test" {
mainBalance=$(imversed query bank balances $address --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
mainBalance=$(echo $mainBalance | sed 's/amount: //g; s/"//g')
testBalanceStart=$(imversed query bank balances $addressTransferTest --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
testBalance=$(echo $testBalanceStart | sed 's/amount: //g; s/"//g')

sleep  5
echo "${yellow}========Step 1: Sending funds to test wallet========${reset}" >&3
hash=$(yes |imversed tx bank send $address $addressTransferTest 1000nimv --fees=200nimv --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash" >&3
sleep  5

echo "${yellow}========Step 2: Return code and nimv value========${reset}" >&3
qrc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|value:.*nimv')
echo "$qrc" >&3
[[ "$qrc" == *"code: 0"* ]]
[[ "$qrc" == *"value: 1000nimv"* ]]
sleep  5

echo "${yellow}========Step 3: Check Test wallet balance========${reset}" >&3
queryBalance=$(imversed query bank balances $addressTransferTest --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
balance=$(echo $queryBalance | sed 's/amount: //g; s/"//g')

echo "${yellow}========Step 4: Verify  money received========${reset}" >&3
echo $balance >&3
echo $testBalance >&3
[ $balance -gt $testBalance ]

echo "${yellow}========Step 5: Send money back========${reset}" >&3
hash=$(yes |imversed tx bank send $addressTransferTest $address 1000nimv --fees=200nimv --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
sleep  5
qrc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|value:.*nimv')
echo "$qrc" >&3
[[ "$qrc" == *"code: 0"* ]]
[[ "$qrc" == *"value: 1000nimv"* ]]

echo "${yellow}========Step 6: Check money are received on main balance========${reset}" >&3
sleep  5
queryBalance=$(imversed query bank balances $address --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
balance=$(echo $queryBalance | sed 's/amount: //g; s/"//g')
echo "$balance" >&3
[ $balance -le $mainBalance ]
}