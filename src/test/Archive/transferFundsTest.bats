#!/usr/local/bin/bats
load ~/imv-ecommerce-autotests/envnft.profile


@test "transfer funds test" {
mainBalance=$(imversed query bank balances $address --node=http://qt.imversed.com:26657 | grep -o 'amount:.*')
mainBalance=$(echo $mainBalance | sed 's/amount: //g; s/"//g')
testBalanceStart=$(imversed query bank balances $addressTransferTest --node=http://qt.imversed.com:26657 | grep -o 'amount:.*')
testBalance=$(echo $testBalanceStart | sed 's/amount: //g; s/"//g')
sleep  6


echo "${yellow}========Step 1: Sending funds to test wallet========${reset}" >&3
hash=$(yes |imversed tx bank send \
$address $addressTransferTest \
100nimv \
--node http://qt.imversed.com:26657 \
--chain-id imversed-test-1 --fees 200nimv | grep -o 'txhash:.*')

txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash" >&3
sleep  10

echo "${yellow}========Step 2: Return code and nimv value========${reset}" >&3
qrc=$(imversed q tx --type=hash "$txhash" --node=http://qt.imversed.com:26657 | grep -o 'code:.*\|value:.*nimv')
echo "$qrc" >&3
[[ "$qrc" == *"code: 0"* ]]
[[ "$qrc" == *"value: 1000nimv"* ]]
sleep  6

echo "${yellow}========Step 3: Check Test wallet balance========${reset}" >&3
queryBalance=$(imversed query bank balances $addressTransferTest --node=http://qt.imversed.com:26657 | grep -o 'amount:.*')
balance=$(echo $queryBalance | sed 's/amount: //g; s/"//g')

echo "${yellow}========Step 4: Verify  money received========${reset}" >&3
echo $balance >&3
echo $testBalance >&3
[ $balance -gt $testBalance ]

echo "${yellow}========Step 5: Send money back========${reset}" >&3
hash=$(yes |imversed tx bank send \
$addressTransferTest $address \
100nimv \
--node http://qt.imversed.com:26657 \
--chain-id imversed-test-1 --fees 200nimv | grep -o 'txhash:.*')

txhash=$(echo "$hash" | sed 's/txhash: //g')
sleep  6
qrc=$(imversed q tx --type=hash "$txhash" --node=http://qt.imversed.com:26657 --chain-id imversed-test-1 | grep -o 'code:.*\|value:.*nimv')
echo "$qrc" >&3
[[ "$qrc" == *"code: 0"* ]]
[[ "$qrc" == *"value: 1000nimv"* ]]

echo "${yellow}========Step 6: Check money are received on main balance========${reset}" >&3
sleep  6
queryBalance=$(imversed query bank balances $address --node=http://qt.imversed.com:26657 | grep -o 'amount:.*')
balance=$(echo $queryBalance | sed 's/amount: //g; s/"//g')
echo "$balance" >&3
[ $balance -le $mainBalance ]
}