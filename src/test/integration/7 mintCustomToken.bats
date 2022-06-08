#!/usr/bin/env bats

@test "Mint custom token" {
  mint=$(yes | imversed tx currency mint 100000000nikotoken --from imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc --chain-id test_123-1 --gas auto | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  hash=$(imversed q tx "$mint" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$hash" == "code: 0" ]
}





