#!/usr/bin/env bats

@test "Send Coins" {
  transaction=$(yes | imversed tx bank send "validator-imv" imv1szff7jw36thxct4smg8vlxunktxn4w0sr4p7tj \
                150stake --chain-id test_123-1 | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  hash=$(imversed q tx "$transaction" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$hash" == "code: 0" ]

#Check the dosh
  dosh=$(imversed q bank balances imv1szff7jw36thxct4smg8vlxunktxn4w0sr4p7tj \
        --chain-id test_123-1 | grep -o 'amount:.*' | sed 's/amount: //g; s/"//g')
  [ $dosh -gt 0 ]
}