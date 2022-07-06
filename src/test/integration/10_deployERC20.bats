#!/usr/bin/env bats

@test "deploy ERC20 contract" {
cd ~/blockchain-integration-tests/smart_contract/
truffle compile
truffle migrate --network imversed --config ~/blockchain-integration-tests/smart_contract/truffle-config.js
checkContract=$(imversed q erc20 token-pairs | grep -o 'account_owner:.*' | sed 's/account_owner: //g')
echo "$checkContract" >&3
 [ "$checkContract" == "imv184duxpcy0kweggwsz6n40hm23fj90clvat7yyc" ]
}