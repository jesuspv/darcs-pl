# darcs-pl - Pretty Log for Darcs

A `git log --pretty=...` mimic for darcs. Shows one line per patch with relative dates, short hash, tags, and author.

```
* e94571e7 - Skip mark_video_read on prefetch requests (9 minutes ago) <Jesus Pardillo>
* fb4799f2 - Fix EasySpeech: use IIFE build instead of ES module build (24 minutes ago) <Jesus Pardillo>
* 2dc7ec64 - (tag: v1.9.0) Display PnL as P&L (3 months ago) <dev@jesuspardillo.com>
```

All `darcs log` flags are passed through:

```
darcs-pl --last=10
darcs-pl --patches="Fix"
darcs-pl --repo /path/to/repo
```

## Installation

With nix flakes:

```
nix run github:jesuspv/darcs-pl
```

Or install permanently via [Home Manager](https://github.com/nix-community/home-manager):

```nix
home.packages = [ inputs.darcs-pl.packages.${system}.default ];
```

Otherwise, copy the self-contained script `darcs-pl` to a directory in your `$PATH` and confirm you have `bash`, `gawk`, and `darcs` installed.
