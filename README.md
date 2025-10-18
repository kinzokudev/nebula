<div align="center">
  <img src="https://github.com/kinzokudev/nebula/raw/main/assets/nebula_logo.png" align="center" width="144px" height="144px"/>

# NEBULA

**My NixOS configuration flake, back and better than ever**

</div>

---

## Overview

This configuration focuses heavily on simplicity and modularity. Reusable modules are stored in the `modules/` directory, and within the `core/` and `hm/` subdirectories for NixOS and home-manager modules respectively. Repetitive boilerplate is kept to a minimum by having many essential modules set to be enabled by default, with options to configure or disable them individually. The `hosts/` directory contains a subdirectory for each host machine in the configuration. Host machines are defined in the `nixosConfigurations` section of `flake.nix` with a function that handles all the boilerplate, only requiring the hostname and system string to be defined for each host machine.

## The Rewrite

The original version of this config was written by me using [Snowfall Lib](https://github.com/snowfallorg/lib), which is a framework for building configuration flakes. For a while this worked fine, but the way I set up my modules initially was extremely janky, and as the flake grew, I never bothered to do anything about it. So around August of 2024, I had my entire system completely stop working, and I had to reinstall.

After reinstalling, I ended up just using a pretty crappy barebones flake, and I put off rewriting my config in full for the longest time. Hyperfixations got the best of me, and I neglected the fact that my setup was extremely janky and annoying to use, but now, I finally did it.

With that being said, the old version of NEBULA is available at [kinzokudev/nebula-snowfall-archive](https://github.com/kinzokudev/nebula-snowfall-archive).
