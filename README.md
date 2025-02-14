# vix

Vix is a program for interacting with the Nix ecosystem

## Usage

``` shell
vix [global-options] [<command>] [command-options] [arguments ...]
```

## Options

`vix` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit
  -v, --verbose  Verbosity [default: 0]

```

## Sub Commands

`vix` provides the following sub commands:

``` shell
  install, i                         install a package into a profile
  remove, uninstall, u               uninstall packages from a profile
  upgrade, up                        upgrade packages using their most recent flake
  list, ls                           list the installed packages
  rollback, back                     roll back to a previous version of a profile
  history, hist                      show all versions of a profile
  wipe-history, wipe                 delete non-current versions of a profile
  diff-closures, diff                show the closure difference between each version of a profile
  init, fi                           create a flake in the current directory
  metadata, fm                       show flake metadata
  show, fs                           show the outputs provided by a flake
  update, fu                         update flake lock file
  new, fn                            create a flake in the specified directory from a template
  clone, fc                          clone flake repository
  check, fh                          check whether the flake evaluates and run its tests
  archive, fa                        copy a flake and all its inputs to a store
  prefetch, fp                       download the flake source tree into the Nix store
  rebuild, rb                        rebuild the system
  search, s                          search for packages
  develop, dev                       run a dev shell of a derivation build environment
  make, mk                           run make inside a dev shell
  build                              build a derivation or fetch a store path
  run                                run a Nix application
  bundle                             bundle an application so that it works outside of the Nix store
  copy                               start an interactive environment for evaluating Nix expressions
  edit                               open the Nix expression of a Nix package in $EDITOR
  eval                               evaluate a Nix expression
  fmt, format                        reformat your code in the standard style
  repl                               start an interactive environment for evaluating Nix expressions
  path-info, path                    query information about store paths
  why-depends, why                   show why a package has another package in its closure
  env-shell, shell                   run a shell in which the specified packages are available
  print-dev-env, print               print shell code of derivation
  daemon                             daemon to perform store operations on behalf of non-root clients
  realisation-info                   manipulate a Nix realisation
  upgrade-nix                        upgrade Nix to the latest stable version
  registry-add, ra                   create a flake in the current directory
  registry-pin, rp                   pin a flake to its current version
  registry-remove, rr                remove flake from user flake registry
  registry-list, rl                  list available Nix flakes
  config-show                        show the Nix configuration or the value of a specific setting
  config-check                       check your system for potential problems
  derivation-add                     add a store derivation
  derivation-show                    show the contents of a store derivation
  hash-file                          print hash of a regular file
  hash-path                          print hash of the NAR serialisation of a path
  hash-convert                       convert between hash formats
  key-convert                        generate a public key for verifying store paths
  key-generate                       generate a secret key for signing store paths
  nar-cat                            print the contents of a file inside a NAR file on stdout
  nar-dump-path, nar-dump, nar-pack  serialise a path to stdout in NAR format
  nar-ls                             show information about a path inside a NAR file
  store-add                          add a file or directory to the Nix store
  store-cat                          print the contents of a file in the Nix store on stdout
  store-copy-log                     copy build logs between Nix stores
  store-copy-sigs                    copy store path signatures from substituters
  store-delete                       delete paths from the Nix store
  store-diff-closures                show what packages and versions were added and removed
  store-dump-path                    serialise a store path to stdout in NAR format
  store-gc                           perform garbage collection on a Nix store
  store-info, store-ping             test whether a store can be accessed
  store-ls                           show information about a path in the Nix store
  store-make-content-addressed       rewrite a path or closure to content-addressed form
  store-optimise                     replace identical files in the store by hard links
  store-path-from-hash-part          get a store path from its hash part
  store-prefetch-file                download a file into the Nix store
  store-repair                       repair store paths
  store-sign                         sign store paths with a local key
  store-verify                       verify the integrity of store paths
  zsh-completion                     generate the Zsh completion script
  print-doc                          print the documentation

```

## Authors

* Rommel Martínez <ebzzry@icloud.com>

# vix install

`vix install` -- install a package into a profile

## Usage

``` shell
vix install [option...]
```

## Options

`vix install` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Install a package from Nixpkgs:

``` shell
vix install -n hello
```

Install a package from a specific Nixpkgs revision:

``` shell
vix install nixpkgs/d734#hello
```

# vix remove

`vix remove` -- uninstall packages from a profile

## Usage

``` shell
vix remove [option...]
```

## Options

`vix remove` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Remove a package by name:

``` shell
vix uninstall hello
```

Remove all packages:

``` shell
vix uninstall -- --all
```

# vix upgrade

`vix upgrade` -- upgrade packages using their most recent flake

## Usage

``` shell
vix upgrade [option...]
```

## Options

`vix upgrade` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Upgrade a specific package by name:

``` shell
vix upgrade hello
```

# vix list

`vix list` -- list the installed packages

## Usage

``` shell
vix list [option...]
```

## Options

`vix list` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

List packages installed in the default profile:

``` shell
vix list
```

# vix rollback

`vix rollback` -- roll back to a previous version of a profile

## Usage

``` shell
vix rollback [option...]
```

## Options

`vix rollback` accepts the following options:

``` shell
      --help        display usage information and exit
      --version     display version and exit
  -t, --to <VALUE>  specify command

```

## Examples

Roll back your default profile to the previous version:

``` shell
vix rollback
```

Roll back your default profile to version n:

``` shell
vix rollback -t version-profile
```

# vix history

`vix history` -- show all versions of a profile

## Usage

``` shell
vix history [option...]
```

## Options

`vix history` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show the changes between each version of your default profile:

``` shell
vix history
```

# vix wipe-history

`vix wipe-history` -- delete non-current versions of a profile

## Usage

``` shell
vix wipe-history [option...]
```

## Options

`vix wipe-history` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Delete all versions of the default profile older than 30 days:

``` shell
vix wipe-history -- --profile /tmp/profile --older-than 30d
```

# vix diff-closures

`vix diff-closures` -- show the closure difference between each version of a profile

## Usage

``` shell
vix diff-closures [option...]
```

## Options

`vix diff-closures` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show what changed between each version of the NixOS system profile:

``` shell
vix diff-closures -- --profile /nix/var/nix/profiles/system
```

# vix init

`vix init` -- create a flake in the current directory

## Usage

``` shell
vix init [option...]
```

## Options

`vix init` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Create a flake using the default template:

``` shell
vix init
```

# vix metadata

`vix metadata` -- show flake metadata

## Usage

``` shell
vix metadata [option...]
```

## Options

`vix metadata` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show flake metadata:

``` shell
vix metadata
```

# vix show

`vix show` -- show the outputs provided by a flake

## Usage

``` shell
vix show [option...]
```

## Options

`vix show` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show the output attributes provided by the CWD flake:

``` shell
vix show
```

List available templates:

``` shell
vix show templates
```

# vix update

`vix update` -- update flake lock file

## Usage

``` shell
vix update [option...]
```

## Options

`vix update` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Update all inputs:

``` shell
vix update
```

# vix new

`vix new` -- create a flake in the specified directory from a template

## Usage

``` shell
vix new [option...]
```

## Options

`vix new` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Create a flake in the directory `hello':

``` shell
vix new hello
```

Create a flake in the directory `hello' using template haskell-hello:

``` shell
vix new hello -t templates#haskell-hello
```

# vix clone

`vix clone` -- clone flake repository

## Usage

``` shell
vix clone [option...]
```

## Options

`vix clone` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Check out the source code of the dwarffs flake:

``` shell
vix clone dwarffs -- --dest dwarffs
```

# vix check

`vix check` -- check whether the flake evaluates and run its tests

## Usage

``` shell
vix check [option...]
```

## Options

`vix check` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Evaluate the flake in the current directory, and build its checks:

``` shell
vix check
```

# vix archive

`vix archive` -- copy a flake and all its inputs to a store

## Usage

``` shell
vix archive [option...]
```

## Options

`vix archive` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Fetch the dwarffs flake to the local Nix store:

``` shell
vix achive dwarffs
```

# vix prefetch

`vix prefetch` -- download the flake source tree into the Nix store

## Usage

``` shell
vix prefetch [option...]
```

## Options

`vix prefetch` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Download the dwarffs flake:

``` shell
vix prefetch dwarffs
```

# vix rebuild

`vix rebuild` -- rebuild the system

## Usage

``` shell
vix rebuild [-s] [-su]
```

## Options

`vix rebuild` accepts the following options:

``` shell
      --help           display usage information and exit
      --version        display version and exit
  -f, --flake <VALUE>  source flake
  -s, --switch         toggle switch
  -u, --upgrade        toggle upgrade

```

## Examples

Rebuild the system from the flake specified in `~/src/system/':

``` shell
vix rebuild -s -f ~/src/system
```

Rebuild the system from flake and switch to it:

``` shell
vix rebuild -s
```

# vix search

`vix search` -- search for packages

## Usage

``` shell
vix search [-n]
```

## Options

`vix search` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit
  -n, --nixpkgs  toggle Nixpkgs

```

## Examples

Search in Nixpkgs for packages named `firefox':

``` shell
vix search -n firefox
```

Search in Nixpkgs for packages underneath the attribute `gnome3':

``` shell
vix search nixpkgs#gnome3 vala
```

# vix develop

`vix develop` -- run a dev shell of a derivation build environment

## Usage

``` shell
vix develop [option...]
```

## Options

`vix develop` accepts the following options:

``` shell
      --help             display usage information and exit
      --version          display version and exit
  -c, --command <VALUE>  specify command

```

## Examples

Start a dev shell with the build environment of the current directory:

``` shell
vix dev
```

Start a dev shell and run `make' inside:

``` shell
vix dev -c make
```

# vix make

`vix make` -- run make inside a dev shell

## Usage

``` shell
vix make [option...]
```

## Options

`vix make` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Run `make' inside a dev shell:

``` shell
vix make
```

# vix build

`vix build` -- build a derivation or fetch a store path

## Usage

``` shell
vix build [-n]
```

## Options

`vix build` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Build the default package from the flake in the current directory:

``` shell
vix build
```

Build `hello' and `cowsay' from Nixpkgs, leaving two result symlinks:

``` shell
vix build -n hello cowsay
```

# vix run

`vix run` -- run a Nix application

## Usage

``` shell
vix run [option...]
```

## Options

`vix run` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Run `vim' from the `nixpkgs' flake:

``` shell
vix run -n vim
```

# vix bundle

`vix bundle` -- bundle an application so that it works outside of the Nix store

## Usage

``` shell
vix bundle [option...]
```

## Options

`vix bundle` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Bundle `hello':

``` shell
vix bundle -n vim
```

# vix copy

`vix copy` -- start an interactive environment for evaluating Nix expressions

## Usage

``` shell
vix copy [option...]
```

## Options

`vix copy` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Copy all store paths from a local binary cache:

``` shell
vix copy -- --all --from file:///tmp/cache
```

# vix edit

`vix edit` -- open the Nix expression of a Nix package in $EDITOR

## Usage

``` shell
vix edit [option...]
```

## Options

`vix edit` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Open the Nix expression of the `hello' package:

``` shell
vix edit -n hello
```

# vix eval

`vix eval` -- evaluate a Nix expression

## Usage

``` shell
vix eval [option...]
```

## Options

`vix eval` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Evaluate a Nix expression given on the command line:

``` shell
vix eval -- --expr '1 + 2'
```

# vix fmt

`vix fmt` -- reformat your code in the standard style

## Usage

``` shell
vix fmt [option...]
```

## Options

`vix fmt` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Format the current flake:

``` shell
vix fmt
```

# vix repl

`vix repl` -- start an interactive environment for evaluating Nix expressions

## Usage

``` shell
vix repl [option...]
```

## Options

`vix repl` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Evaluate some simple Nix expressions:

``` shell
vix repl
```

# vix path-info

`vix path-info` -- query information about store paths

## Usage

``` shell
vix path-info [option...]
```

## Options

`vix path-info` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Print the store path produced by nixpkgs#hello:

``` shell
vix path -n hello
```

# vix why-depends

`vix why-depends` -- show why a package has another package in its closure

## Usage

``` shell
vix why-depends [option...]
```

## Options

`vix why-depends` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show one path through the dependency graph leading from `hello' to `glibc':

``` shell
vix why -n hello glibc
```

# vix env-shell

`vix env-shell` -- run a shell in which the specified packages are available

## Usage

``` shell
vix env-shell [option...]
```

## Options

`vix env-shell` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Start a shell providing `yt-dlp' from the `nixpkgs' flake:

``` shell
vix shell -n yt-dlp
```

# vix print-dev-env

`vix print-dev-env` -- print shell code of derivation

## Usage

``` shell
vix print-dev-env [option...]
```

## Options

`vix print-dev-env` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Get the build environment:

``` shell
vix print -n hello
```

# vix daemon

`vix daemon` -- daemon to perform store operations on behalf of non-root clients

## Usage

``` shell
vix daemon [option...]
```

## Options

`vix daemon` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Run the daemon:

``` shell
vix daemon
```

Run the daemon and force all connections to be trusted:

``` shell
vix daemon -- --force-trusted
```

# vix realisation-info

`vix realisation-info` -- manipulate a Nix realisation

## Usage

``` shell
vix realisation-info [option...]
```

## Options

`vix realisation-info` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show some information about the realisation of the hello package:

``` shell
vix realisation-info -n hello
```

# vix upgrade-nix

`vix upgrade-nix` -- upgrade Nix to the latest stable version

## Usage

``` shell
vix upgrade-nix [option...]
```

## Options

`vix upgrade-nix` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Upgrade Nix to the stable version declared in Nixpkgs:

``` shell
vix upgrade-nix
```

# vix registry-add

`vix registry-add` -- create a flake in the current directory

## Usage

``` shell
vix registry-add [option...]
```

## Options

`vix registry-add` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Set the `nixpkgs' flake identifier to a specific branch of Nixpkgs:

``` shell
vix registry-add nixpkgs github:NixOS/nixpkgs/nixos-20.03
```

# vix registry-pin

`vix registry-pin` -- pin a flake to its current version

## Usage

``` shell
vix registry-pin [option...]
```

## Options

`vix registry-pin` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Pin `nixpkgs' to its most recent Git revision:

``` shell
vix registry-pin nixpkgs
```

# vix registry-remove

`vix registry-remove` -- remove flake from user flake registry

## Usage

``` shell
vix registry-remove [option...]
```

## Options

`vix registry-remove` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Remove the entry `nixpkgs' from the user registry:

``` shell
vix registry-remove nixpkgs
```

# vix registry-list

`vix registry-list` -- list available Nix flakes

## Usage

``` shell
vix registry-list [option...]
```

## Options

`vix registry-list` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show the contents of all registries:

``` shell
vix registry-list
```

# vix config-show

`vix config-show` -- show the Nix configuration or the value of a specific setting

## Usage

``` shell
vix config-show [option...]
```

## Options

`vix config-show` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show configuration:

``` shell
vix config-show
```

# vix config-check

`vix config-check` -- check your system for potential problems

## Usage

``` shell
vix config-check [option...]
```

## Options

`vix config-check` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Check for problems:

``` shell
vix config-check
```

# vix derivation-add

`vix derivation-add` -- add a store derivation

## Usage

``` shell
vix derivation-add [option...]
```

## Options

`vix derivation-add` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Add a derivation:

``` shell
vix derivation-add
```

# vix derivation-show

`vix derivation-show` -- show the contents of a store derivation

## Usage

``` shell
vix derivation-show [option...]
```

## Options

`vix derivation-show` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show the `hello' derivation:

``` shell
vix derivation-show -n hello
```

# vix hash-file

`vix hash-file` -- print hash of a regular file

## Usage

``` shell
vix hash-file [option...]
```

## Options

`vix hash-file` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Print hash of `file.txt':

``` shell
vix hash-file file.txt
```

# vix hash-path

`vix hash-path` -- print hash of the NAR serialisation of a path

## Usage

``` shell
vix hash-path [option...]
```

## Options

`vix hash-path` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Print hash of path `/foo/bar/':

``` shell
vix hash-path /foo/bar/
```

# vix hash-convert

`vix hash-convert` -- convert between hash formats

## Usage

``` shell
vix hash-convert [option...]
```

## Options

`vix hash-convert` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Convert a hash:

``` shell
vix hash-convert -- --hash-algo sha1 800d59cfcd3c05e900cb4e214be48f6b886a08df
```

# vix key-convert

`vix key-convert` -- generate a public key for verifying store paths

## Usage

``` shell
vix key-convert [option...]
```

## Options

`vix key-convert` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Convert a secret key to a public key:

``` shell
vix key-convert foo
```

# vix key-generate

`vix key-generate` -- generate a secret key for signing store paths

## Usage

``` shell
vix key-generate [option...]
```

## Options

`vix key-generate` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Generate a new secret key:

``` shell
vix key-generate -- --key-name cache.example.org-1 > ./secret-key
```

# vix nar-cat

`vix nar-cat` -- print the contents of a file inside a NAR file on stdout

## Usage

``` shell
vix nar-cat [option...]
```

## Options

`vix nar-cat` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

To display a file in a NAR file:

``` shell
vix nar-cat ./hello.nar /share/man/man1/hello.1.gz | gunzip
```

# vix nar-dump-path

`vix nar-dump-path` -- serialise a path to stdout in NAR format

## Usage

``` shell
vix nar-dump-path [option...]
```

## Options

`vix nar-dump-path` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

To serialise directory `foo' as a NAR file:

``` shell
vix nar-dump ./foo > foo.nar
```

# vix nar-ls

`vix nar-ls` -- show information about a path inside a NAR file

## Usage

``` shell
vix nar-ls [option...]
```

## Options

`vix nar-ls` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

To list a specific file in a NAR file:

``` shell
vix nar-ls -- --long ./hello.nar /bin/hello
```

# vix store-add

`vix store-add` -- add a file or directory to the Nix store

## Usage

``` shell
vix store-add [option...]
```

## Options

`vix store-add` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Add a directory to the store:

``` shell
vix store-add ./dir
```

# vix store-cat

`vix store-cat` -- print the contents of a file in the Nix store on stdout

## Usage

``` shell
vix store-cat [option...]
```

## Options

`vix store-cat` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show the contents of a file in a binary cache:

``` shell
vix store-cat --store https://cache.nixos.org/ /nix/store/0i2jd68mp5g6h2sa5k9c85rb80sn8hi9-hello-2.10/bin/hello
```

# vix store-copy-log

`vix store-copy-log` -- copy build logs between Nix stores

## Usage

``` shell
vix store-copy-log [option...]
```

## Options

`vix store-copy-log` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Copy build logs between Nix stores:

``` shell
vix copy-log --from https://cache.nixos.org --eval-store auto nixpkgs#hello
```

# vix store-copy-sigs

`vix store-copy-sigs` -- copy store path signatures from substituters

## Usage

``` shell
vix store-copy-sigs [option...]
```

## Options

`vix store-copy-sigs` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Copy sigs:

``` shell
vix store-copy-sigs
```

# vix store-delete

`vix store-delete` -- delete paths from the Nix store

## Usage

``` shell
vix store-delete [option...]
```

## Options

`vix store-delete` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Delete a specific store path:

``` shell
vix store-delete /nix/store/yb5q57zxv6hgqql42d5r8b5k5mcq6kay-hello-2.10
```

# vix store-diff-closures

`vix store-diff-closures` -- show what packages and versions were added and removed

## Usage

``` shell
vix store-diff-closures [option...]
```

## Options

`vix store-diff-closures` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Show what got added and removed between two versions of the NixOS system
profile:

``` shell
vix store-diff-closures /nix/var/nix/profiles/system-655-link /nix/var/nix/profiles/system-658-link
```

# vix store-dump-path

`vix store-dump-path` -- serialise a store path to stdout in NAR format

## Usage

``` shell
vix store-dump-path [option...]
```

## Options

`vix store-dump-path` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

To get a NAR from the binary cache https://cache.nixos.org/:

``` shell
vix store-dump-path -- --store https://cache.nixos.org/ /nix/store/7crrmih8c52r8fbnqb933dxrsp44md93-glibc-2.25 > glibc.nar
```

# vix store-gc

`vix store-gc` -- perform garbage collection on a Nix store

## Usage

``` shell
vix store-gc [option...]
```

## Options

`vix store-gc` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Delete unreachable paths in the Nix store:

``` shell
vix store-gc
```

# vix store-info

`vix store-info` -- test whether a store can be accessed

## Usage

``` shell
vix store-info [option...]
```

## Options

`vix store-info` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Test whether connecting to a remote Nix store via SSH works:

``` shell
vix store-info -- --store ssh://mac1
```

# vix store-ls

`vix store-ls` -- show information about a path in the Nix store

## Usage

``` shell
vix store-ls [option...]
```

## Options

`vix store-ls` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

To list the contents of a store path in a binary cache:

``` shell
vix store-ls -- --store https://cache.nixos.org/ --long --recursive /nix/store/0i2jd68mp5g6h2sa5k9c85rb80sn8hi9-hello-2.10
```

# vix store-make-content-addressed

`vix store-make-content-addressed` -- rewrite a path or closure to content-addressed form

## Usage

``` shell
vix store-make-content-addressed [option...]
```

## Options

`vix store-make-content-addressed` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Create a content-addressed representation of the closure of `hello':

``` shell
vix store-make-content-addressed -n hello
```

# vix store-optimise

`vix store-optimise` -- replace identical files in the store by hard links

## Usage

``` shell
vix store-optimise [option...]
```

## Options

`vix store-optimise` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Optimise the Nix store:

``` shell
vix store-optimise
```

# vix store-path-from-hash-part

`vix store-path-from-hash-part` -- get a store path from its hash part

## Usage

``` shell
vix store-path-from-hash-part [option...]
```

## Options

`vix store-path-from-hash-part` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Return the full store path with the given hash part:

``` shell
vix store-path-from-hash-part --store https://cache.nixos.org/ 0i2jd68mp5g6h2sa5k9c85rb80sn8hi9
```

# vix store-prefetch-file

`vix store-prefetch-file` -- download a file into the Nix store

## Usage

``` shell
vix store-prefetch-file [option...]
```

## Options

`vix store-prefetch-file` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Download a file to the Nix store:

``` shell
vix store-prefetch-file https://releases.nixos.org/nix/nix-2.3.10/nix-2.3.10.tar.xz
```

# vix store-repair

`vix store-repair` -- repair store paths

## Usage

``` shell
vix store-repair [option...]
```

## Options

`vix store-repair` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Repair a store path, after determining that it is corrupt:

``` shell
vix store-repair /nix/store/yb5q57zxv6hgqql42d5r8b5k5mcq6kay-hello-2.10
```

# vix store-sign

`vix store-sign` -- sign store paths with a local key

## Usage

``` shell
vix store-sign [option...]
```

## Options

`vix store-sign` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Sign store:

``` shell
vix store-sign
```

# vix store-verify

`vix store-verify` -- verify the integrity of store paths

## Usage

``` shell
vix store-verify [option...]
```

## Options

`vix store-verify` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

## Examples

Verify the entire Nix store:

``` shell
vix store-verify -- --all
```

# vix zsh-completion

`vix zsh-completion` -- generate the Zsh completion script

## Usage

``` shell
vix zsh-completion 
```

## Options

`vix zsh-completion` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

# vix print-doc

`vix print-doc` -- print the documentation

## Usage

``` shell
vix print-doc 
```

## Options

`vix print-doc` accepts the following options:

``` shell
      --help     display usage information and exit
      --version  display version and exit

```

