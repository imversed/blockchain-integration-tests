#!/usr/bin/env bats
@test "Export Genesis" {
kill $(ps aux | grep 'imversed' | awk '{print $2}') || true
imversed export &> latestGen.json
state=$(cat latestGen.json | grep -o 'Keycard.*')
echo $state >&3
[[ "$state" == *"Keycard"* ]]
}