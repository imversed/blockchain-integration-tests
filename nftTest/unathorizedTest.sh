#!/bin/sh

denom="coin6"
address="imv1szff7jw36thxct4smg8vlxunktxn4w0sr4p7tj"
recipient="imv1x2ft5kx5vlj93gymyveulha5sepcq9mwlnpzmu"
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

#unauthorized issue test

echo "${yellow}========Unauthorized Denom Issue========${reset}"
log=$(yes | imversed tx nft issue $denom --from=$address --name=$denom --mint-restricted=false --update-restricted=false --chain-id=toby --fees=200nimv --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*\|raw_log:.*')
if [[ "$log" != *"code: 0"* ]]
then echo "${green} $log ${reset}"
else  echo "${red} Test Failed. ${reset}"
fi