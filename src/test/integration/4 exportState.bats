#!/usr/bin/env bats
@test "Export Genesis" {
kill $(ps aux | grep '[i]mversed' | awk '{print $1}')
imversed export &> latestGen.json
state=$(cat latestGen.json | grep -o 'Keycard.*')
echo $state >&3
[[ "$state" == *"Keycard"* ]]
}