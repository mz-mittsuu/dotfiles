# 🖥️ Environment Setup

この文書では、WSL 2 / Ubuntu 26.04上に開発環境を構築する手順を説明する。

原則としてバージョンは固定せず、環境構築時点で利用可能な最新の安定版を導入する。

Ubuntuで適切なパッケージが提供されている場合はAPTを優先し、それ以外は各プロダクトが公式に提供する導入方法を使用する。


## 📦 APT

最初にパッケージ情報を更新する。

```sh
sudo apt update
```

インストール済みパッケージを、その時点で利用可能な最新バージョンへ更新する。

```sh
sudo apt full-upgrade
```

開発環境で使用するパッケージを導入する。

```sh
sudo apt install \
  bat \
  btop \
  build-essential \
  ccache \
  cmake \
  eza \
  fd-find \
  fzf \
  gdb \
  gh \
  git \
  git-delta \
  golang-go \
  latexmk \
  ninja-build \
  nodejs \
  npm \
  pkg-config \
  ripgrep \
  rustup \
  shellcheck \
  stow \
  texlive-full \
  tmux \
  unzip \
  valgrind \
  vim \
  zip \
  zoxide \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting
```

Ubuntuのパッケージ名と実際のコマンド名が異なるものがある。

```text
bat      -> batcat
fd-find  -> fdfind
```

対話環境ではdotfilesから`bat`と`fd`のaliasを提供する。


## 📁 XDG Base Directories

XDG Base Directoryに従ってユーザーデータを配置する。

必要な基本ディレクトリを作成する。

```sh
mkdir -p \
  "$HOME/.cache" \
  "$HOME/.config" \
  "$HOME/.local/bin" \
  "$HOME/.local/share" \
  "$HOME/.local/state"
```

セットアップ中に`~/.local/bin`へ導入するコマンドを利用できるよう、現在のshellでPATHを設定する。

```sh
export PATH="$HOME/.local/bin:$PATH"
```

このPATH設定の永続化は後でdotfilesから行う。

XDG Base Directoryの標準的なfallback pathを現在のshellにも設定する。

```sh
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
```

使用するXDG Base Directoryは以下となる。

```text
XDG_CACHE_HOME  -> ~/.cache
XDG_CONFIG_HOME -> ~/.config
XDG_DATA_HOME   -> ~/.local/share
XDG_STATE_HOME  -> ~/.local/state
```

ユーザー用コマンドは原則として以下へ配置する。

```text
~/.local/bin
```


## 🗂️ Dotfiles

dotfilesはGNU Stowで管理する。

repositoryを`~/.dotfiles`へcloneする。

```sh
git clone git@github.com:mz-mittsuu/dotfiles.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
```

現在のStow packageは以下となる。

```text
bat
git
latex
oh-my-posh
pip
ripgrep
tmux
vim
zsh
```

各packageを`$HOME`へ展開する。

```sh
stow \
  --target="$HOME" \
  bat \
  git \
  latex \
  oh-my-posh \
  pip \
  ripgrep \
  tmux \
  vim \
  zsh
```

Zshの設定により、`~/.local/bin`へのPATH設定とXDG Base Directoryのfallback設定が永続化される。


## 🔀 Git

ユーザー固有のGit identityは、repositoryで管理する共通設定とは分離して`~/.config/git/config.local`で管理する。

dotfilesに含まれるexampleをコピーして作成する。

```sh
cp \
  "$HOME/.config/git/config.local.example" \
  "$HOME/.config/git/config.local"
```

作成したファイルを編集し、GitHubで使用する名前とメールアドレスを設定する。

```gitconfig
[user]
    name = John Doe
    email = 123456789+johndoe@users.noreply.github.com
```

メールアドレスには、個人のメールアドレスを公開しないためGitHubのnoreplyメールアドレスの使用を推奨する。

GitHubで提供されるnoreplyメールアドレスは、GitHubのメール設定で確認する。

`config.local`はユーザー固有の設定であるためGit管理の対象外とし、`config.local.example`のみrepositoryで管理する。


## 🐹 Go

GoはUbuntu APTの`golang-go`から導入する。

Goでユーザー用コマンドを導入する場合は以下へ配置する。

```text
~/.local/bin
```


## 📚 ghq

ghqはGoを使用して導入する。

```sh
GOBIN="$HOME/.local/bin" \
  go install github.com/x-motemen/ghq@latest
```

`@latest`を使用し、導入時点の最新安定版を取得する。

更新時も同じコマンドを使用する。

インストール先は以下となる。

```text
~/.local/bin/ghq
```

ghqの追加Zsh completionは導入しない。


## 🎨 Oh My Posh

Oh My Poshは公式installerを使用して導入する。

```sh
curl -s https://ohmyposh.dev/install.sh | \
  bash -s -- -d "$HOME/.local/bin"
```

インストール先は以下となる。

```text
~/.local/bin/oh-my-posh
```

installerが取得するthemesは以下へ配置される。

```text
~/.cache/oh-my-posh/themes
```

installerの実行には`unzip`が必要となるため、先にAPTで導入する。

shell integrationとtheme configurationはdotfilesで管理する。


## 🐍 Python and uv

Ubuntuのsystem Python環境は変更しない。

system Pythonは以下となる。

```text
/usr/bin/python3
```

system Pythonへproject packageを直接インストールしない。

uvは公式standalone installerを使用して導入する。

```sh
curl -LsSf https://astral.sh/uv/install.sh | \
  env \
    UV_INSTALL_DIR="$HOME/.local/bin" \
    UV_NO_MODIFY_PATH=1 \
    sh
```

インストール先は以下となる。

```text
~/.local/bin/uv
~/.local/bin/uvx
```

installerにはPATHを変更させず、`~/.local/bin`のPATH設定はdotfilesで管理する。

開発用Pythonを導入する。

```sh
uv python install 3.14
```

この指定ではPython 3.14系の利用可能な最新安定版を使用する。

patch versionは固定しない。

uvが管理するPythonは以下へ配置される。

```text
~/.local/share/uv/python/
```

コマンドの役割は以下のように分離する。

```text
python3      -> Ubuntu system Python
python3.14   -> uv-managed Python
```

uvは以下の用途で使用する。

- Python version management
- project dependencies
- project virtual environments
- Python CLI tools

一時的に実行するPython toolには必要に応じて`uvx`を使用する。


## 🦀 Rust

rustupはUbuntu APTから導入する。

stable toolchainを初期化する。

```sh
rustup default stable
```

`stable`を使用し、導入時点の最新安定toolchainを使用する。

Ubuntuの`rustup` packageは以下のproxyを提供する。

```text
/usr/bin/cargo -> rustup
/usr/bin/rustc -> rustup
```

rustupの標準レイアウトを使用する。

```text
~/.rustup
```

Ubuntuの`rustup` packageを使用するため、`~/.cargo/bin`をPATHへ追加する必要はない。


## 🐚 Zsh

Zsh、Zsh Autosuggestions、Zsh Syntax HighlightingはUbuntu APTから導入する。

Zsh configurationはdotfilesで管理する。

runtime directoryを作成する。

```sh
mkdir -p \
  "$XDG_CACHE_HOME/zsh/completions" \
  "$XDG_STATE_HOME/zsh"
```

historyは以下へ保存する。

```text
$XDG_STATE_HOME/zsh/history
```

completion cacheは以下へ保存する。

```text
$XDG_CACHE_HOME/zsh/.zcompdump
```

uvとuvxのcompletionを、導入済みのバージョン自身から生成する。

```sh
uv generate-shell-completion zsh \
  > "$XDG_CACHE_HOME/zsh/completions/_uv"

uvx --generate-shell-completion zsh \
  > "$XDG_CACHE_HOME/zsh/completions/_uvx"
```

生成されるファイルは以下となる。

```text
$XDG_CACHE_HOME/zsh/completions/_uv
$XDG_CACHE_HOME/zsh/completions/_uvx
```

以下のcompletionはUbuntu / Zsh環境から利用できる。

```text
cargo
gh
git
npm
rustup
ssh
systemctl
```

ghqの追加completionは導入しない。

configurationとcompletionの設定後、Zshをlogin shellに設定する。

```sh
chsh -s /usr/bin/zsh
```

設定を反映するため、WSLのshellを開き直す。


## 📄 LaTeX

TeX LiveとlatexmkはUbuntu APTから導入する。

対象パッケージは以下となる。

```text
latexmk
texlive-full
```

latexmk configurationはdotfilesで管理する。

build configurationは以下となる。

```text
LaTeX       uplatex
BibTeX      upbibtex
DVI to PDF  dvipdfmx
MakeIndex   mendex
Output      build/
```

日本語フォントにはHarano Aji Fontsを使用し、PDFへ埋め込むようsystem-wideに設定する。

```sh
sudo kanji-config-updmap-sys haranoaji
```

設定を確認する。

```sh
kanji-config-updmap-sys status
```

以下の設定になっていることを確認する。

```text
CURRENT family for ja: haranoaji
```

build pathは以下となる。

```text
latexmk -> upLaTeX -> DVI -> dvipdfmx -> PDF
```

PDFのフォント埋め込みは`pdffonts`で確認する。

```sh
pdffonts build/test.pdf
```

Latin fontとHarano Aji Minchoの双方について`emb=yes`となっていることを確認する。


## 🧹 Cleanup

環境構築後、不要になった依存パッケージを削除する。

```sh
sudo apt autoremove
```

取得済みパッケージファイルのうち、現在ダウンロードできなくなった古いファイルを削除する。

```sh
sudo apt autoclean
```

通常のセットアップでは`apt clean`は実行しない。

APTのパッケージキャッシュをすべて削除する必要がある場合のみ明示的に実行する。

---

[← READMEへ戻る](../README.md)
