#!/usr/local/bin/bats
. ~/imv-ecommerce-autotests/envnft.profile


@test "transfer funds test" {
mainBalance=$(imversed query bank balances $address --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
mainBalance=$(echo $mainBalance | sed 's/amount: //g; s/"//g')
testBalanceStart=$(imversed query bank balances $addressTransferTest --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
testBalance=$(echo $testBalanceStart | sed 's/amount: //g; s/"//g')
sleep  5
hash=$(yes |imversed tx bank send $address $addressTransferTest 1000nimv --fees=200nimv --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash"
sleep  5
qrc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|value:.*nimv')
echo "$qrc"
[[ "$qrc" == *"code: 0"* ]] && [[ "$qrc" == *"value: 1000nimv"* ]]
sleep  5
queryBalance=$(imversed query bank balances $addressTransferTest --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
balance=$(echo $queryBalance | sed 's/amount: //g; s/"//g')

echo $balance
echo $testBalance

[ $balance -gt $testBalance ]


hash=$(yes |imversed tx bank send $addressTransferTest $address 1000nimv --fees=200nimv --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
sleep  5
qrc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|value:.*nimv')
echo "$qrc"
[[ "$qrc" == *"code: 0"* ]] || [[ "$qrc" == *"value: 1000nimv"* ]]


sleep  5
queryBalance=$(imversed query bank balances $address --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
balance=$(echo $queryBalance | sed 's/amount: //g; s/"//g')
echo "$balance"
[ $balance -le $mainBalance ]
}