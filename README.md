# Setup

In this repository, all files for nix configuration and the home-manager are stored.

In order to use it, a working installation of nix and home-manager is necessary.

After this, the directories in this repository need to be linked to places in the
`~/.config` directory to be properly set up. In order to do this, clone the
repository, switch into its root directory and execute:

```bash
ln -s $(pwd)/nix ~/.config/nix
ln -s $(pwd)/home-manager ~/.config/nixpkgs
```

After this, just run `home-manager switch` and the environment should be built.
