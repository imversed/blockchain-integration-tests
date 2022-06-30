#!/usr/bin/env bats

@test "Send custom token to another wallet" {
  transaction=$(yes | imversed tx bank send "niko-test" imv1v4kuj7f4cwh3hum8vxqjd824j0jrwjv5fvyda8 \
                100nikotoken --chain-id test_123-1 | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  hash=$(imversed q tx "$transaction" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$hash" == "code: 0" ]

  #Check second wallet got custom token

  query=$(imversed q bank balances imv1v4kuj7f4cwh3hum8vxqjd824j0jrwjv5fvyda8 --chain-id test_123-1 | grep -o "denom: .*")
  echo "$query" >&3
  [[ "$query" == *"nikotoken"* ]]


  transaction=$(yes | imversed tx bank send "niko-test-wallet" imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc \
                1000000montanatoken --chain-id test_123-1 | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  hash=$(imversed q tx "$transaction" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$hash" == "code: 0" ]

  #Check second wallet got custom token

  query=$(imversed q bank balances imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc --chain-id test_123-1 | grep -o "denom: .*")
  echo "$query" >&3
  [[ "$query" == *"montanatoken"* ]]
}





