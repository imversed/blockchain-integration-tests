#!/bin/sh
. ./common.sh

# issue denom
echo "${yellow}========Step 1: Issuing Denom========${reset}"
hash=$(yes | imversed tx nft issue $denom --from=$address --name=$denom --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=200nimv --oracle-url=$oracle_url --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
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
sleep 5
echo "${yellow}========Oracle URL========${reset}"
rc=$(imversed q nft denom $denom --node=http://metachain-staging.fdvr.co:26657 | grep -o 'oracle_url:.*')
oracle=$(echo "$rc" | sed 's/oracle_url: //g')
if [ "$oracle" != "$oracle_url" ]
then echo "${red} Test Failed. Check oracle_url ${reset}"
else echo "${green} Test Passed. oracle_url valid ${reset}"
fi