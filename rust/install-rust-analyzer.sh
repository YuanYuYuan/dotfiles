#!/usr/bin/env bash
 
rustup component add rust-analyzer
ln -s $(rustup which --toolchain stable rust-analyzer) ~/.cargo/bin/rust-analyzer
