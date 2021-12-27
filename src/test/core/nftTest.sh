#!/bin/sh
. ~/imv-ecommerce-autotests/envnft.profile

#issue denom
echo "${yellow}========Step 1: Issuing Denom========${reset}"
hash=$(yes | imversed tx nft issue "$denom" --from="$address" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=200nimv --oracle-url="$oracle_url" --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash"
sleep 5
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$rc"
if [ "$rc" != "code: 0" ]
then echo "${red} Test Failed. Check logs: ${reset}"
      log=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'raw_log:.*')
      echo "${red} $log ${reset}"
else echo "${green} Test Passed. Denom issued ${reset}"
fi
# check oracle url
echo "${yellow}========Oracle URL========${reset}"
rc=$(imversed q nft denom $denom --node=http://metachain-staging.fdvr.co:26657 | grep -o 'oracle_url:.*')
oracle=$(echo "$rc" | sed 's/oracle_url: //g')
if [ "$oracle" != "$oracle_url" ]
then echo "${red} Test Failed. Check oracle_url ${reset}"
else echo "${green} Test Passed. oracle_url valid ${reset}"
fi

# check nft info
echo "${yellow}========Step 2: Сhecking Author And Denom ID========${reset}"
sleep 5
qrc=$(imversed query nft collection $denom --node=http://metachain-staging.fdvr.co:26657 | grep -o 'id:.*\|creator:.*')
echo "$qrc"
if [[ "$qrc" != *"id: "$DN""* ]] || [[ "$qrc" != *"creator: "$AD""* ]]
then echo "${red} Test Failed, check the owner and id ${reset}"
else echo "${green} Test Passed. Denom id and author verified ${reset}"
fi

# mint nft
echo "${yellow}========Step 3: Minting NFT========${reset}"
sleep  5
mrc=$(yes | imversed tx nft mint "$denom"  "$denom"  --recipient="$address" --from="$address" --node=http://metachain-staging.fdvr.co:26657 --fees=200nimv | grep -o 'txhash:.*')
txhash=$(echo "$mrc" | sed 's/txhash: //g')
echo "$txhash"
sleep 5
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
if [ "$rc" != "code: 0" ]
then echo "${red} Test Failed: please check logs${reset}"
      log=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'raw_log:.*')
      echo "${red} $log ${reset}"
else echo "${green} Test Passed. Nft was minted! ${reset}"
fi

# transfer nft
echo "${yellow}========Step 4: Transfering NFT========${reset}"
sleep 5
trc=$(yes | imversed tx nft transfer "$recipient" "$denom" "$denom" --from="$address" --node=http://metachain-staging.fdvr.co:26657 --fees=200nimv | grep -o 'txhash:.*')
txhash=$(echo "$trc" | sed 's/txhash: //g')
echo "$txhash"
sleep 5
RC=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
if [ "$RC" != "code: 0" ]
then echo "${red} Test Failed. Please check logs ${reset}"
      log=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -0 'raw_log:.*')
      echo "${red} $log ${reset}"
else echo "${green} Test Passed. Nft transfered ${reset}"
fi

# check nft supply
echo "${yellow}========Step 5: Checking NFT Supplied========${reset}"
sleep 5
SUP=$(imversed query nft supply "$denom"  --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
if [ "$SUP" != 'amount: "1"' ]
then echo "${red} Test Failed. Please check full response: ${reset}"
      log=$(imversed query nft supply "$denom"  --node=http://metachain-staging.fdvr.co:26657)
      echo "${red} $log ${reset}"
else echo "${green} Test Passed, nft supplied ${reset}"
fi
# transfer coins