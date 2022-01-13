#!/usr/local/bin/bats
. ~/imv-ecommerce-autotests/envnft.profile

@test "update test" {
# issue denom
echo "${yellow}========Step 1: Issuing Denom========${reset}"
hash=$(yes | imversed tx nft issue $denom --from=$address --name=$denom --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=200nimv --oracle-url=$oracle_url --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash"
sleep 5
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$rc"
[ "$rc" == "code: 0" ]

#update denom
echo "${yellow}========Step 2: Updating Denom Info ========${reset}"
hash=$(yes | imversed tx nft update $denom --from=$address --name="$denom"-edited --mint-restricted=false --update-restricted=false --fees=200nimv --oracle-url="$oracle_url_edit" --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash"
sleep 5
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'name:.*\|oracle_url:.*\|code:.*')
echo "$rc"
[[ "$rc" == *"name: "$denom"-edited"* ]] || [[ "$rc" == *"oracle_url: "$oracle_url_edit""* ]] || [[ "$rc" == *"code: 0"* ]]
}