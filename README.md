### Build and test OpenCV for RISC-V

Directory layout should be as follows:

- opencv/
- opencv_extra/
- <this_repository>/
  - workspace/ - directory with opencv builds and caches
  - scripts/   - directory with built and test scripts
  - ...
  - run.sh     - entrypoint script

Steps:
1. `./run.sh` - will build docker image and run the container
2. Inside the container: `build.sh` - build opencv
3. Inside the container: `test.sh` - run tests

Modify scripts in the `scripts/` directory according to your needs.