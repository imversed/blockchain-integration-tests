#!/usr/local/bin/bats
load ~/imv-ecommerce-autotests/envnft.profile

#issue denom
@test "nftTest" {
echo "${yellow}========Step 1: Issuing Denom========${reset}" >&3
hash=$(yes | imversed tx nft issue "$denom" --from="$address" --name="$denom" --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=200nimv --oracle-url="$oracle_url" --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash" >&3
sleep 5
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$rc" >&3
[ "$rc" == "code: 0" ]
# check oracle url
echo "${yellow}========Oracle URL========${reset}" >&3
rc=$(imversed q nft denom $denom --node=http://metachain-staging.fdvr.co:26657 | grep -o 'oracle_url:.*')
oracle=$(echo "$rc" | sed 's/oracle_url: //g')
echo "$oracle" >&3
[ "$oracle" == "$oracle_url" ]

# check nft info
echo "${yellow}========Step 2: Сhecking Author And Denom ID========${reset}" >&3
sleep 5
qrc=$(imversed query nft collection $denom --node=http://metachain-staging.fdvr.co:26657 | grep -o 'id:.*\|creator:.*')
echo "$qrc" >&3
[[ "$qrc" == *"id: "$DN""* ]]
[[ "$qrc" == *"creator: "$AD""* ]]

# mint nft
echo "${yellow}========Step 3: Minting NFT========${reset}" >&3
sleep  5
mrc=$(yes | imversed tx nft mint "$denom"  "$denom"  --recipient="$address" --from="$address" --node=http://metachain-staging.fdvr.co:26657 --fees=200nimv | grep -o 'txhash:.*')
txhash=$(echo "$mrc" | sed 's/txhash: //g')
echo "$txhash" >&3
sleep 5
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$rc" >&3
[ "$rc" == "code: 0" ]

# transfer nft
echo "${yellow}========Step 4: Transfering NFT========${reset}" >&3
sleep 5
trc=$(yes | imversed tx nft transfer "$recipient" "$denom" "$denom" --from="$address" --node=http://metachain-staging.fdvr.co:26657 --fees=200nimv | grep -o 'txhash:.*')
txhash=$(echo "$trc" | sed 's/txhash: //g')
echo "$txhash" >&3
sleep 5
RC=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$RC" >&3
[ "$RC" == "code: 0" ]


# check nft supply
echo "${yellow}========Step 5: Checking NFT Supplied========${reset}" >&3
sleep 5
SUP=$(imversed query nft supply "$denom"  --node=http://metachain-staging.fdvr.co:26657 | grep -o 'amount:.*')
echo "$SUP" >&3
[ "$SUP" == 'amount: "1"' ]
}
