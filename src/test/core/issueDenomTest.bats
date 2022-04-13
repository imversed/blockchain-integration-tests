#!/usr/local/bin/bats
load ~/imv-ecommerce-autotests/envnft.profile

@test "Issue Denom" {
  echo "${yellow}========Step 1: Issuing Denom========${reset}" >&3

  hash=$(yes | imversed tx nft issue "$denom" --from="$address" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=imversed-test-1 --fees=200nimv --oracle-url="$oracle_url" --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
  txhash=$(echo "$hash" | sed 's/txhash: //g')
  echo "$txhash"  >&3
  sleep 6
  rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
  echo "$rc" >&3
  [ "$rc" == "code: 0" ]
}