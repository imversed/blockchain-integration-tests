#!/bin/sh
. ~/imv-ecommerce-autotests/envnft.profile

#FOR NOW IT ACTS LIKE KEY NOT FOUND ERROR TEST.
echo "${yellow}#========Step 1: Generate test wallet ========#${reset}"
rc=$(imversed keys add "$user" | grep -o 'address:.*')
wallet=$(echo "$rc" | sed 's/address: //g')
echo "${green} Generated empty test wallet - $wallet ${reset}"

echo "${yellow}#========Step 2: Try Issue Denom With No Funds ========#${reset}"
hash=$(yes | imversed tx nft issue "$denom" --from="$wallet" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=200nimv --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'Error:.*')
txhash=$(echo "$hash" | sed 's/Error: //g')
echo "$txhash"

echo "${yellow}#========Step 3: Verify user cant issue due to no funds ========#${reset}"
sleep 5
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$rc"
if [ "$rc" != "code: 0" ]
then echo "${green} lowFundsTest.sh Passed. User cant pay for issue ${reset}"
else echo "${red} lowFundsTest.sh Failed. ${reset}"
fi

