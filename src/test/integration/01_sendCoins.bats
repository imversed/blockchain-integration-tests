#!/usr/bin/env bats

@test "Send Coins" {
  transaction=$(yes | imversed tx bank send "validator-imv" imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc \
                1500000000aimv --chain-id test_123-1 | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  hash=$(imversed q tx "$transaction" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$hash" == "code: 0" ]
#Send to second wallet
    transaction=$(yes | imversed tx bank send "validator-imv" imv1v4kuj7f4cwh3hum8vxqjd824j0jrwjv5fvyda8 \
                1500000000aimv --chain-id test_123-1 | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  hash=$(imversed q tx "$transaction" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$hash" == "code: 0" ]

#Check the dosh
  dosh=$(imversed q bank balances imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc \
        --chain-id test_123-1 | grep -o 'amount:.*' | sed 's/amount: //g; s/"//g')
  [ $dosh -gt 0 ]
}