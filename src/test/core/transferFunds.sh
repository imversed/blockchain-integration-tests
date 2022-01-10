#!/bin/sh
. ~/imv-ecommerce-autotests/envnft.profile

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
if [[ "$qrc" != *"code: 0"* ]] || [[ "$qrc" != *"value: 1000nimv"* ]]
then echo "${red} transferTest_1 Failed, nimv were not sent ${reset}"
else echo "${green} transferTest_1 Passed. User sent nimv to test user ${reset}"
fi

sleep  5
queryBalance=$(imversed query bank balances $addressTransferTest --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
balance=$(echo $queryBalance | sed 's/amount: //g; s/"//g')

echo $balance
echo $testBalance

if  [ $balance -gt $testBalance ]
then echo "${green} transferTest_2 Passed. nimv were received ${reset}"
else echo "${red} transferTest_2 Failed, nimv were not credited ${reset}"
fi

hash=$(yes |imversed tx bank send $addressTransferTest $address 1000nimv --fees=200nimv --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
sleep  5
qrc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|value:.*nimv')
echo "$qrc"
if [[ "$qrc" != *"code: 0"* ]] || [[ "$qrc" != *"value: 1000nimv"* ]]
then echo "${red} transferTest_3 Failed, nimv were not sent back ${reset}"
else echo "${green} transferTest_3 Passed. User sent nimv to main user ${reset}"
fi

sleep  5
queryBalance=$(imversed query bank balances $address --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
balance=$(echo $queryBalance | sed 's/amount: //g; s/"//g')
echo "$balance"
if [ $balance -le $mainBalance ]
then echo "${green} transferTest_4 Passed. nimv were received ${reset}"
else echo "${red} transferTest_4 Failed, nimv were not credited ${reset}"
fi