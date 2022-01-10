#!/bin/sh
. ~/imv-ecommerce-autotests/envnft.profile

mainBalance=$(imversed query bank balances $address --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')

hash=$(yes |imversed tx bank send $address $addressTransferTest 1000nimv --fees=200nimv --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|value:.*')
echo "$qrc"
if [[ "$qrc" != *"code: 0"* ]] || [[ "$qrc" != *"value: 1000nimv"* ]]
then echo "${red} transferTest_1 Failed, nimv were not sent ${reset}"
else echo "${green} transferTest_1 Passed. User sent nimv to test user ${reset}"
fi
queryBalance=$(imversed query bank balances $addressTransferTest --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
echo "$queryBalance"
if [ "$queryBalance" != "1000" ]
then echo "${red} transferTest_2 Failed, nimv were not credited ${reset}"
else echo "${green} transferTest_2 Passed. nimv were received ${reset}"
fi

hash=$(yes |imversed tx bank send $addressTransferTest $address 1000nimv --fees=200nimv --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|value:.*')
echo "$qrc"
if [[ "$qrc" != *"code: 0"* ]] || [[ "$qrc" != *"value: 1000nimv"* ]]
then echo "${red} transferTest_3 Failed, nimv were not sent back ${reset}"
else echo "${green} transferTest_3 Passed. User sent nimv to main user ${reset}"
fi

queryBalance=$(imversed query bank balances $address --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
echo "$queryBalance"
if [ "$queryBalance" -le "$mainBalance" ]
then echo "${red} transferTest_4 Failed, nimv were not credited ${reset}"
else echo "${green} transferTest_4 Passed. nimv were received ${reset}"
fi