#!/usr/bin/env bats

@test "Issue Token" {
  issue=$(yes | imversed tx currency issue nikotoken "" --from imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc --chain-id test_123-1 --gas auto | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  hash=$(imversed q tx "$issue" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$hash" == "code: 0" ]
}