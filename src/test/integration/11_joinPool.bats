#!/usr/bin/env bats
@test "Join Pool" {
  transaction=$(yes | imversed tx bank send "niko-test" imv1v4kuj7f4cwh3hum8vxqjd824j0jrwjv5fvyda8 \
                15000000nikotoken --chain-id test_123-1 | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  hash=$(imversed q tx "$transaction" --chain-id test_123-1 | grep -o 'code:.*')
  [ "$hash" == "code: 0" ]

  checkPool=$(imversed q pools pool 1 | sed '12!d' | sed 's/amount: //g')
  joinPool=$(yes | imversed tx pools join-pool --max-amounts-in=100000000aimv \
  --max-amounts-in=99000000montanatoken --pool-id=1 --share-amount-out=100000000000000000000 \
  --from=imv1v4kuj7f4cwh3hum8vxqjd824j0jrwjv5fvyda8 | grep -o 'txhash:.*' | sed 's/txhash: //g')
  sleep 6
  isJoined=$(imversed q tx "$joinPool" --chain-id test_123-1 | grep -o 'code:.*')
  checkExpectedPool=$(imversed q pools pool 1 | sed '12!d' | sed 's/amount: //g')
  [[ "$checkPool" != "$checkExpectedPool" ]]
}