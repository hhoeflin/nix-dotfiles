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

# Programs

## Spotify playback

Spotify playback is supported with the `spotify-tui`, which can be run with the `spt` command.
In order for playback to work, the spotify-daemon has to run. Currently, it does not seem
to work to invoke it as a service. A workaround is to run
```bash
spotifyd --no-daemon
```
in a console. Then the service should be available from the spotify-tui device menu.

The password for the Spotify account is stored using the `pass` program, which uses
a `gpg` identityfor encryption. In order to generate a new one, do
```bash
gpg --generate-key
gpg -k
```

And use the listed id to create a password store

```bash
pass --init
pass add spotify
```

In order to see the password, do
```
pass show spotify
``
