#!/usr/local/bin/bats
load ~/imv-ecommerce-autotests/envnft.profile


@test "startChain" {
RUN ~/imv-ecommerce-autotests/chainStart.sh &
sleep 8
onlineChain=$(imversed status test 2>&1 >/dev/null | grep -o '"NodeInfo":.*')
echo "$onlineChain" >&3
[[ "$onlineChain" == *"NodeInfo"* ]]
echo "penis" >&3
}