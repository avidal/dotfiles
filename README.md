## dotfiles

### requirements

```
# macos
$ brew install fish stow git neovim
```

```
# fedora
$ sudo dnf install fish stow neovim
```

```
# debian / ubuntu
$ sudo apt install fish stow neovim
```

### usage

After installing the packages above, switch shell to fish and restart:

```
$ chsh --shell $(which fish)
```

Install fisher:

```
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

Install mise:

```
curl https://mise.run | sh
```

Install rustup:

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Stow the packages:

```
$ stow fish
$ stow nvim
$ stow git
# ...
```

Install the global toolchains with mise:

```
$ mise install
```

### stow options (and adopting new files)

The `.stowrc` in this repository includes three options, one of which introduces some significant
beahvior change from the defaults.

`-v`

Turns on verbose mode which helpfully prints all actions `stow` will take.

`--dotfiles`

Instructs `stow` to replace `dot-` with `.` on file and directory prefixes when stowing packages.
This is a matter of personal preference, but I prefer the `dot-` prefix in my repository.

`--no-folding`

This option disables what `stow` calls [tree folding](https://www.gnu.org/software/stow/manual/stow.html#Tree-folding),
where `stow` will attempt to minimize the number of links that it creates. Read the link if you're
interested in the details.

Disabling folding means that instead of optimally creating links to directories, `stow` will instead
only link files. This will help keep your dotfiles repository clean from cruft placed there by tools
at runtime.

For example, I prefer the `fish` shell, and I use the `fisher` plugin manager for fish. I have
`fisher` configured to download plugins and their assorted configuration into
`~/.config/fish/plugged`. With the normal `stow` behavior, if I run `stow fish`, it'll create a link
from `~/.config/fish` to `~/dotfiles/fish/dot-config/fish`, which will result in the downloaded
plugin sources to show up in my dotfiles repository (at `~/dotfiles/fish/dot-config/fish/plugged`)
and necessitate a `.gitignore` entry.

Instead, disable tree folding. This way the only files that will exist in this repository are the
ones I put there myself.

If you need to introduce a new file (for example, writing a new fish function) the simplest thing to
do is:

```
$ touch ~/dotfiles/fish/dot-config/fish/functions/new-function.fish
$ pushd ~/dotfiles && stow fish && popd
$ vim ~/.config/fish/functions/new-function.fish
$ ... hack hack hack ...
```
