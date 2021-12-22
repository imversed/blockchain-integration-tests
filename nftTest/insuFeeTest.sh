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
denom="coin70"
address="imv1szff7jw36thxct4smg8vlxunktxn4w0sr4p7tj"
oracle_url=https://api-staging.fdvr.co/instagram-nft/oracle-validate
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

# issue denom
echo "${yellow}========Step 1: Issuing Denom With low Fee========${reset}"
hash=$(yes | imversed tx nft issue $denom --from=$address --name=$denom --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=20nimv --oracle_url=$oracle_url --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|raw_log:.*')
sleep 5
echo "${yellow}========Step 2: Verifying error code========${reset}"
if [[ "$hash" != *"code: 0"* ]]
#|| [[ "$hash" == *"raw_log: insufficient fee"* ]]
then echo "${green} Test Passed. Insufficient Fees ${reset}"
else echo "${red} Test Failed. ${reset}"
fi