## Setup

```bash
git clone git@github.com:benjamin-thomas/dotfiles.git ~/code/github.com/benjamin-thomas/dotfiles
cd ~/code/github.com/benjamin-thomas/dotfiles
./create_symlinks.rb
```

Use this command to cleanup/find old/broken links

```bash
# apt-get install symlinks
symlinks ~
symlinks ~/.local/* | grep dangling

# Better
find -xtype l
# Review then delete
find -xtype l -delete
find ~ -maxdepth 1 -xtype l
find ~ -maxdepth 1 -xtype l -delete
```
