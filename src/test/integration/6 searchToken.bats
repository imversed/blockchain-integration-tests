#!/usr/bin/env bats

@test "Find token" {
  query=$(imversed q currency list | grep -o "denom: .*")
  echo "$query" >&3
  [[ "$query" == *"nikotoken"* ]]
}