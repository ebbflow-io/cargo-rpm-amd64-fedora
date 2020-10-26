#!/bin/sh -l
set -eux
# Taken from https://github.com/zhxiaogg/cargo-static-build, not sure if all needed

# hack, move home to $HOME(/github/home)
ln -s /root/.cargo $HOME/.cargo
ln -s /root/.rustup $HOME/.rustup

# go to the repo root
cd $GITHUB_WORKSPACE
mkdir -p target
chmod 0777 ./target
export CARGO_TARGET_DIR=$GITHUB_WORKSPACE/target
sh -c "$*"
chmod 0777 ./target
