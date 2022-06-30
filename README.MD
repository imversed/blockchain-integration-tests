# Imversed-integration-tests
Integration tests for Imversed blockchain.

Current project aims to test our Imversed binaries running local blockchain inside docker container.
Test goals are to cover most of our functionality and provide safe and stable bug free use of Imversed.
Tests are using bats framework and xunit viewer for better visual recognition of test results. 
That allows us to easily manage, write and maintain any CLI test.

## How-to-use
Build image from docker file, then run docker container:
`docker run -d -t --rm --name <container_name> <container_image>`.

After container is up and running start the local chain detached by executing:
`docker exec -d <container_name> sh runChain.sh`.

It should take some time for it to init the chain and add test wallets to it.
After that you got yourself your own local blockchain.

Now you may test functionality of imversed binary.

### Run-Tests
If you eager to run tests, then we should execute "bats" to start running integration tests:
`bats src/test/integration/ || true`.

I use `|| true` so tests wont stop if fail.
>*might check if framework has a skip_failed option nowdays*

### Generate-and-view-test-report
Add flags to "Run tests" command we described previously:
`--report-formatter junit -r -t` to get a report file after tests are done.

To make report ".xml" file readable and visualise it, execute: `fulldivenft xunit-viewer -r report.xml`.
It should generate `index.html` report file.

Copy generated report files to your host machine with `docker cp <container_name>:<tests_directory>/report.xml index.html .`

### Test-report-example

<img src=https://user-images.githubusercontent.com/71702772/176718783-63a16a2d-3068-40fd-aedb-431bab653a45.png width=80%>
