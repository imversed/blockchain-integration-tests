#!/usr/local/bin/bats
. ~/imv-ecommerce-autotests/envnft.profile

@test "Issue Denom" {
  hash=$(yes | imversed tx nft issue "$denom" --from="$address" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=200nimv --oracle-url="$oracle_url" --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
  txhash=$(echo "$hash" | sed 's/txhash: //g')
  echo "$txhash"
  sleep 5
  rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
  echo "$rc"
  [ "$rc" == "code: 0" ]
}