#!/usr/local/bin/bats
. ~/imv-ecommerce-autotests/envnft.profile

@test "insufficient fee test" {
  echo "${yellow}========Step 1: Issuing Denom With low Fee========${reset}"
  hash=$(yes | imversed tx nft issue "$denom" --from="$address" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=20nimv --oracle-url="$oracle_url" --schema=https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|raw_log:.*')
  sleep 5
  echo "${yellow}========Step 2: Verifying error code========${reset}"

  [[ "$hash" != *"code: 0"* ]]
}