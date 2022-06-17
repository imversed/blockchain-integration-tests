#!/usr/bin/env bats

@test "Mint Nft" {
  yes | imversed tx nft mint nikotest keycard_red --name "Integration RED" \
      --data "{ 'description': 'Red Keycard is the most desirable item in Tarkov',
      'ImageUrl': 'https://static.wikia.nocookie.net/escapefromtarkov_gamepedia/images/2/2c/Lab_Red_keycard_ins.PNG/revision/latest/scale-to-width-down/715?cb=20190719221657'}" \
      --from "niko-test" --chain-id test_123-1
  sleep 6

  imversed q nft token nikotest keycard_red --chain-id test_123-1

  yes | imversed tx nft mint nikotest keycard_blue --name "Integration BLUE" \
      --data "{ 'description': 'Blue Keycard leads to medical spawn loot in TerraGroup Labs',
      'ImageUrl': 'https://static.wikia.nocookie.net/escapefromtarkov_gamepedia/images/d/dd/Lab_Blue_keycard_ins.png/revision/latest/scale-to-width-down/725?cb=20190412025429'}" \
      --from "niko-test" --chain-id test_123-1
  sleep 6
  imversed q nft token nikotest keycard_blue --chain-id test_123-1

  yes | imversed tx nft mint nikotest keycard_black --name "Integration BLACK" \
      --data "{ 'description': 'Black Keycard can be traded or found in different locations. Leads to lose loot and LEDx spawn',
      'ImageUrl': 'https://static.wikia.nocookie.net/escapefromtarkov_gamepedia/images/5/56/Lab_Black_keycard_ins.png/revision/latest/scale-to-width-down/723?cb=20190411181213'}" \
      --from "validator-imv" --chain-id test_123-1
  sleep 6
  imversed q nft token nikotest keycard_black --chain-id test_123-1

  yes | imversed tx nft mint nikotest keycard_violet --name "Integration VIOLET" \
      --data "{ 'description': 'The Rarest keykard in Tarkov, You are helluva lucky if you get your hands on it',
      'ImageUrl': 'https://static.wikia.nocookie.net/escapefromtarkov_gamepedia/images/0/01/Lab_Violet_keycard_ins.png/revision/latest/scale-to-width-down/685?cb=20190411181403'}" \
      --from "validator-imv" --chain-id test_123-1
  sleep 6
  imversed q nft token nikotest keycard_violet --chain-id test_123-1

  echo >&3 | imversed q nft collection nikotest
}