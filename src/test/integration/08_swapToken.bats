#!/usr/bin/env bats
@test "Swap Tokens" {
swapAmount=$(imversed q pools estimate-swap-exact-amount-in 1 imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc 10000nikotoken --swap-route-denoms montanatoken --swap-route-pool-ids 1 | grep -o 'tokenOutAmount:.*')
echo "$swapAmount" >&3
swapToken=$(yes | imversed tx pools swap-exact-amount-in 10000aimv  1 --swap-route-pool-ids 1 --swap-route-denoms montanatoken --from imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc | grep -o 'txhash:.*' | sed 's/txhash: //g')
sleep 6
query=$(imversed q tx "$swapToken" | grep -o 'code:.*')
[ "$query" == "code: 0" ]
query=$(imversed q bank balances imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc --chain-id test_123-1 | grep -o "denom:.*")
echo "$query" >&3
[[ "$query" == *"montanatoken"* ]]
}