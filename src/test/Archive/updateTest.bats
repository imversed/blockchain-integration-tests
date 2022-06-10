#!/usr/local/bin/bats
load ~/imv-ecommerce-autotests/envnft.profile

@test "update test" {
# issue denom
echo "${yellow}========Step 1: Issuing Denom========${reset}" >&3
hash=$(yes | imversed tx nft issue $denom --from=$address --name=$denom --mint-restricted=false --update-restricted=false --chain-id=imversed-test-1 --fees=200nimv --oracle-url=$oracle_url --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash" >&3
sleep 6
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$rc" >&3
[ "$rc" == "code: 0" ]

#update denom
echo "${yellow}========Step 2: Updating Denom Info ========${reset}" >&3
hash=$(yes | imversed tx nft update $denom --from=$address --name="$denom"-edited --mint-restricted=false --update-restricted=false --fees=200nimv --oracle-url="$oracle_url_edit" --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash" >&3
sleep 6
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'name:.*\|oracle_url:.*\|code:.*')
echo "$rc" >&3
[[ "$rc" == *"name: "$denom"-edited"* ]]
[[ "$rc" == *"oracle_url: "$oracle_url_edit""* ]]
[[ "$rc" == *"code: 0"* ]]
}