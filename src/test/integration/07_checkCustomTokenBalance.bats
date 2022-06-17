#!/usr/bin/env bats

@test "Check balance with custom token" {
  query=$(imversed q bank balances imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc --chain-id test_123-1 | grep -o "denom: .*")
  echo "$query" >&3
  [[ "$query" == *"nikotoken"* ]]
  query=$(imversed q bank balances imv1v4kuj7f4cwh3hum8vxqjd824j0jrwjv5fvyda8 --chain-id test_123-1 | grep -o "denom: .*")
  echo "$query" >&3
  [[ "$query" == *"montanatoken"* ]]
}