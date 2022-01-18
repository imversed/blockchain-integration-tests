#!/usr/local/bin/bats
load ~/imv-ecommerce-autotests/envnft.profile

@test "lowFundsTest" {
echo "${yellow}#========Step 1: Try Issue Denom With No Funds ========#${reset}" >&3
hash=$(yes | imversed tx nft issue "$denom" --from="$lowFundWallet" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=200nimv --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|raw_log:.*')
echo "$hash" >&3
[[ "$hash" == *"code: 5"* ]] && [[ "$hash" == *"insufficient funds"* ]]
}