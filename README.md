### Build and test OpenCV for RISC-V

Directory layout should be as follows:

- _opencv/_ - opencv sources
- _opencv_extra/_ - opencv test data
- _<this_repository>/_
  - _workspace/_ - directory with opencv builds and caches
  - _scripts/_ - directory with build and test scripts
  - ...
  - _run.sh_ - entrypoint script

Steps:
1. `./run.sh` - will build docker image and run the container
2. Inside the container: `build.sh` - build opencv
3. Inside the container: `test.sh` - run tests

Modify scripts in the `scripts/` directory according to your needs.