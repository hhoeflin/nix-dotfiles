# Setup

In this repository, all files for nix configuration and the home-manager are stored.
Home-manager here uses a setup using flakes. Very helpful blogs in order to
convert your home manager use to flakes are [Blog 1][blog_1] and [Blog 2][blog_2].

[blog_1]: https://dee.underscore.world/blog/home-manager-flakes/
[blog_2]: https://dzone.com/articles/nixos-home-manager-on-native-nix-flake-installatio

In order to use it, a working installation of nix is necessary. For installing nix in
single-user mode, do

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```
and otherwise instruction can be found in the [Nix Manual][nix_manual_install]. As we
are using flakes for home-manager, a separate installation step is not
needed anymore. At the end of the install, the following code activates nix:

```bash
. $HOME/.nix-profile/etc/profile.d/nix.sh
```
and should be added to the .bashrc (unless otherwise managed).

[nix_manual_install]: https://nixos.org/manual/nix/unstable/installation/installing-binary.html

In order to have an appropriate configuration for nix, we need to link
its config files in the correct location:

```bash
ln -s $(pwd)/nix ~/.config/nix
```

Now we can install home-manager as well as our entire user configurations using our flakes setup.
For this in the root of this repository do:

```bash
nix build .#hhoeflin
./result/activate
```

and home-manager will be built and the home-folder configuration created. For the
next iterations you can then do

```bash
home-manager switch --flake .#hhoeflin
```
or if you are not in the root of `nix-dotfiles`, then just replace `.` with the
path to the dotfiles.

This way, the `hhoeflin` or any other configuration that is also available
can easily be run.

A great source of information for nix is also [nix.dev][nix.dev].

[nix.dev]: https://nix.dev/

# Programs

## Spotify playback (only in hhoeflin)

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
```
