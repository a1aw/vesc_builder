# vesc_builder
A docker environment for compiling VESC Tool.

Currently a Ubuntu 24.04 docker environment is used. Could change to another distro later on.
The build is now targeted at 6.02 only. If you want to build newer versions, the script has to be changed.

## Usage

```bash
./start_build_tool.sh
```

To cross-compile for other platforms, need to modify the docker commands in `start_build_tool.sh` with the `--platform linux/arm64` argument. And prepare multiarch environment for docker by installing `qemu-system binfmt-support qemu-user-static`, or https://github.com/multiarch/qemu-user-static/

```bash
#...
docker build --platform linux/arm64 # ...
docker run --platform linux/arm64  # ...
#...
```

## License
Licensed under MIT License.
