#!/bin/sh

#Var legend:
#denom  - Denom id, Denom name
#adress  - Your address
#recipient - recipient address
#======Response Codes======#
#RC  - response code
#QRC - query response code
#TRC - transfer response code
#MRC - mint response code
#==========================#

denom="team715"
address="imv1szff7jw36thxct4smg8vlxunktxn4w0sr4p7tj"
oracle_url=https://api-staging.fdvr.co/instagram-nft/oracle-validate
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

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
echo "${yellow}========Oracle URL========${reset}"
rc=$(imversed q nft denom $denom --node=http://metachain-staging.fdvr.co:26657 | grep -o 'oracle_url:.*')
oracle=$(echo "$rc" | sed 's/oracle_url: //g')
if [ "$oracle" != "$oracle_url" ]
then echo "${red} Test Failed. Check oracle_url ${reset}"
else echo "${green} Test Passed. oracle_url valid ${reset}"
fi