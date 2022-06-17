#!/usr/bin/env bats

@test "Issue Denom" {
  getDenom=$(yes | imversed tx nft issue nikotest --name="integradenom" --mint-restricted=false \
  --update-restricted=false --from "niko-test" --chain-id test_123-1 | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  hash=$(imversed q tx "$getDenom" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$hash" == "code: 0" ]
}