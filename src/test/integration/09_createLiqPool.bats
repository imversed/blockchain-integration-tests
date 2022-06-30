#!/usr/bin/env bats
@test "Create liquidity pool" {
  yes | imversed tx pools create-pool  \
  --pool-file ~/imv-ecommerce-autotests/pool.json \
  --from imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc \
  --chain-id test_123-1 --gas auto
  sleep 6
  #check pools created
  query=$(imversed q pools pools | grep -o "id:.*")
  [ "$query" == "id: \"1\"" ]
}