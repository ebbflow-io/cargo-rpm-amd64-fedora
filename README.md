# `cargo rpm` Build Environment (fedora amd64)

Provides a build environment for executing `cargo rpm build` [1] and producing statically linked binaries for the built `.rpm` package.

This build on a `fedora:32` base image and targets `x86_64-unknown-linux-musl`.

The interface for this package was inspired/copied from the cargo-static-build [2] action.

[1] `cargo rpm` provided by iqlusion
- https://github.com/iqlusioninc/cargo-rpm
- https://crates.io/crates/cargo-rpm

[2] https://github.com/zhxiaogg/cargo-static-build

**NOTE**: This package may fail to build your project if your build links against other OS-provided libraries. Feel free to open a pull-request to modify the `Dockerfile` so your project can build.

## Inputs

`cmd` - The command to be executed inside the container. Defaults to `cargo rpm build -v`

## Outputs

None, besides the `rpm` package that is built. The built `.rpm` will be located in `target/x86_64-unknown-linux-musl/release/rpmbuild/RPMS/x86_64/<RPM>`.

## Example Usage

```yaml
name: RPM Static Build

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: RPM Build
      uses: ebbflow-io/cargo-rpm-amd64-fedora@master
```

A working example can be found in use by Ebbflow to build its client package for various OS and CPU architectures [here](https://github.com/ebbflow-io/ebbflow/blob/master/.github/workflows/continuous-integration.yml).
