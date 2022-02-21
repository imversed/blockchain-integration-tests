#!/usr/bin/env bats

setup() {
  # executed before each test
  load ~/imv-ecommerce-autotests/envnft.profile
}

@test "IssueTestDenom" {
  echo "${yellow}========Step 1: Issuing Denom========${reset}" >&3
hash=$(yes | imversed tx nft issue nikotestingtokens --from="$address" --name=nikotestingtokens --mint-restricted=false --update-restricted=false --chain-id=imversed --fees=200nimv --oracle-url="$oracle_url" --schema==https://metachain-web-staging.fdvr.co/nft/schemas/schema.json --node=http://metachain-staging.fdvr.co:26657 | grep -o 'txhash:.*')
txhash=$(echo "$hash" | sed 's/txhash: //g')
echo "$txhash" >&3
sleep 6
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$rc" >&3
[ "$rc" == "code: 0" ]
# check oracle url
echo "${yellow}========Oracle URL========${reset}" >&3
rc=$(imversed q nft denom nikotestingtokens --node=http://metachain-staging.fdvr.co:26657 | grep -o 'oracle_url:.*')
oracle=$(echo "$rc" | sed 's/oracle_url: //g')
echo "$oracle" >&3
[ "$oracle" == "$oracle_url" ]
}

@test "mintTokenWithData" {
mintResponseCode=$(yes | imversed tx nft mint nikotestingtokens instczrickroll --name="You've been rickrolled" --uri="https://www.instagram.com/p/CaCUgl9toIw/" --data \
  '{"preview": "https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png?w=1024", "author":{"name":"NikoTestUser",
                  "account":"nikotestuser",
                  "isVerified":false,
                    "avatar":"https://scontent-frx5-2.cdninstagram.com/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=scontent-frx5-2.cdninstagram.com&_nc_cat=1&_nc_ohc=uO3NZ1JDo1EAX91wvEa&edm=ABFeTR8BAAAA&ccb=7-4&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2-ccb7-4&oh=00_AT__JKSAegBS5T6UGeYsPFyhQ-77qZzacNzMGFrO73a7Fw&oe=620B0C8F&_nc_sid=93c1bc"},
                      "url":"https://www.instagram.com/p/CaCUgl9toIw/"}'\
  --from inst-test --node=http://metachain-staging.fdvr.co:26657 --fees 200nimv | grep -o 'txhash:.*')
txhash=$(echo "$mintResponseCode" | sed 's/txhash: //g')
echo "$txhash" >&3
sleep 6
rc=$(imversed q tx --type=hash "$txhash" --node=http://metachain-staging.fdvr.co:26657 | grep -o 'code:.*')
echo "$rc" >&3
[ "$rc" == "code: 0" ]
}
