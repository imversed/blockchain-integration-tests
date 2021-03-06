#!/usr/local/bin/bats
load ~/imv-ecommerce-autotests/envnft.profile

#unauthorized issue test

@test "unauthorized test" {
echo "${yellow}========Unauthorized Denom Issue========${reset}" >&3
log=$(yes | imversed tx nft issue "$denom" --from="$address" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=toby --fees=200nimv --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|raw_log:.*')
echo "$log" >&3
[[ "$log" != *"code: 0"* ]]
}