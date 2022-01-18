#!/bin/sh
. ~/imv-ecommerce-autotests/envnft.profile

# issue denom

echo "${yellow}========Step 1: Issuing Denom With low Fee========${reset}"
hash=$(yes | imversed tx nft issue "$denom" --from="$address" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=20nimv --oracle-url="$oracle_url" --schema=https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|raw_log:.*')
sleep 5
echo "${yellow}========Step 2: Verifying error code========${reset}"

if [[ "$hash" != *"code: 0"* ]]
then echo "${green} insuFeeTest.sh Passed. Insufficient Fees ${reset}"
else echo "${red} insuFeeTest.sh Test Failed. ${reset}"
fi