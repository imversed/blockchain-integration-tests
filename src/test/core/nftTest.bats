#!/usr/local/bin/bats
. ~/imv-ecommerce-autotests/envnft.profile


#issue denom
@test "nftTest" {
echo "${yellow}========Step 1: Issuing Denom========${reset}"
hash=$(yes | imversed tx nft issue "$denom" --from="$address" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=200nimv --oracle-url="$oracle_url" --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash"
sleep 5
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$rc"
[ "$rc" == "code: 0" ]
# check oracle url
echo "${yellow}========Oracle URL========${reset}"
rc=$(imversed q nft denom $denom --node=http://metachain-staging.fdvr.co:26657 | grep -o 'oracle_url:.*')
oracle=$(echo "$rc" | sed 's/oracle_url: //g')
[ "$oracle" == "$oracle_url" ]

# check nft info
echo "${yellow}========Step 2: Сhecking Author And Denom ID========${reset}"
sleep 5
qrc=$(imversed query nft collection $denom --node=http://metachain-staging.fdvr.co:26657 | grep -o 'id:.*\|creator:.*')
echo "$qrc"
[[ "$qrc" == *"id: "$DN""* ]] || [[ "$qrc" == *"creator: "$AD""* ]]

# mint nft
echo "${yellow}========Step 3: Minting NFT========${reset}"
sleep  5
mrc=$(yes | imversed tx nft mint "$denom"  "$denom"  --recipient="$address" --from="$address" --node=http://metachain-staging.fdvr.co:26657 --fees=200nimv | grep -o 'txhash:.*')
txhash=$(echo "$mrc" | sed 's/txhash: //g')
echo "$txhash"
sleep 5
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
[ "$rc" == "code: 0" ]

# transfer nft
echo "${yellow}========Step 4: Transfering NFT========${reset}"
sleep 5
trc=$(yes | imversed tx nft transfer "$recipient" "$denom" "$denom" --from="$address" --node=http://metachain-staging.fdvr.co:26657 --fees=200nimv | grep -o 'txhash:.*')
txhash=$(echo "$trc" | sed 's/txhash: //g')
echo "$txhash"
sleep 5
RC=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
[ "$RC" == "code: 0" ]


# check nft supply
echo "${yellow}========Step 5: Checking NFT Supplied========${reset}"
sleep 5
SUP=$(imversed query nft supply "$denom"  --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
[ "$SUP" == 'amount: "1"' ]
}
