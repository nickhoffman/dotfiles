## Nick Hoffman's Dotfiles

Dotfiles I have used and tweaked for the past couple of years. They're designed to work on GNU/Linux, and am slowly modifying them to work on Mac OS X, too.

## Setup

<table>
  <tr>
    <th>Hardware</th>
    <th>OS</th>
    <th>Terminal</th>
    <th>Shell</th>
    <th>Editor</th>
    <th>Version control</th>
    <th>Multiplexer</th>
  </tr>
  <tr>
    <td>Lenovo T430s</td>
    <td>Kubuntu</td>
    <td>Konsole</td>
    <td>Bash</td>
    <td>ViM</td>
    <td>Git</td>
    <td>tmux</td>
  </tr>
  <tr>
    <td>15" MacBook Pro</td>
    <td>Mac OS X</td>
    <td>iTerm2</td>
    <td>Bash</td>
    <td>ViM</td>
    <td>Git</td>
    <td>tmux</td>
  </tr>
</table>

## Install

1. Clone this repository.

2. Run `linker.sh` to clone and symlink to the dotfiles. You'll be prompted to overwrite any existing files.

## Git Subtree

1. Add the subtree as a remote.

    `git remote add -f tpope-vim-surround https://bitbucket.org/vim-plugins-mirror/vim-surround.git`

2. Add the subtree.

    `git subtree add --prefix .vim/bundle/tpope-vim-surround tpope-vim-surround master --squash`

3. To update a subtree:

    ```
    git fetch tpope-vim-surround master
    git subtree pull --prefix .vim/bundle/tpope-vim-surround tpope-vim-surround master --squash
    ```
