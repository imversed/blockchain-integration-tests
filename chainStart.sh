rm -rf ~/.imversed
nodeOffline=$(imversed status test 2>&1 >/dev/null | grep -o 'Error:.*')
echo "$nodeOffline" >&3
[[ "$nodeOffline" == *"Error: post failed:"* ]]
echo "node is Offline" >&3
yes | imversed keys add validator-imv
imversed init test --chain-id test_123-1
imversed add-genesis-account validator-imv 100000000000stake --keyring-backend os
imversed gentx validator-imv 10000000stake --chain-id test_123-1
imversed collect-gentxs
imversed start &
echo "Starting chain" >&3