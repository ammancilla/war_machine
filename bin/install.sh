#!/usr/bin/env sh

# War Machine - MacOS

#
# • CONFIG
#

if [ $DEBUG ]; then
	set -xeE
fi

if [ $VERBOSE ]; then
	set -v
fi

export CHSH=no
export RUNZSH=no
export ZSH=$HOME/.oh-my-zsh
export WAR_MACHINE=$HOME/.war_machine

#
# • FUNCTIONS
#
function systemCheck {
	local OS=$(uname)

	if [ $OS != "Darwin" ]; then
		echo "🥴 • Unsupported OS '$OS'"
		exit 1
	fi

	if [ -z $(which curl) ]; then
		echo "🥴 • Install curl first"
		exit 1
	fi
}

function brewInstall {
	for formula in $@
	do
		if [ $(which $formula) ] || [ "$(brew ls $formula 2>/dev/null)" ]; then
			echo "✅ • $formula"
		else
			brew install $formula
		fi
	done
}

function brewCaskInstall {
	for app in $@
	do
		if [ $(which $app) ] || [ "$(brew cask ls $app 2>/dev/null)" ]; then
			echo "✅ • $app"
		else
			brew install --cask $app
		fi
	done
}

function remoteScriptInstall {
	local shell=$2

	case $shell in
		bash)
			/usr/bin/env bash -c "$(curl -fsSL $1)"
			;;

		*)
			/usr/bin/env sh -c "$(curl -fsSL $1)"
			;;
	esac
}

function installDraculaTheme {
	local DRACULA_TERMINAL=$HOME/src/github.com/dracula/terminal-app
	local DRACULA_ZSH=$HOME/src/github.com/dracula/zsh

	if [ -d $DRACULA_TERMINAL ]; then
		echo "✅ • Dracula - Terminal APP"
	else
		git clone https://github.com/dracula/terminal-app.git $DRACULA_TERMINAL
	fi

	if [ -e $ZSH/themes/dracula.zsh-theme ]; then
		echo "✅ • Dracula - ZSH"
	else
		git clone https://github.com/dracula/zsh.git $DRACULA_ZSH
		ln -s $DRACULA_ZSH/dracula.zsh-theme $ZSH/themes/dracula.zsh-theme
	fi
}

function dotfiles {
	for FILE in $@
	do
		local DOTFILE=$HOME/.$FILE

		if [ -e $DOTFILE ]; then
			rm -f $DOTFILE.warmachine
			cp $DOTFILE $DOTFILE.warmachine
			rm $DOTFILE
		fi

		ln -s $WAR_MACHINE/$FILE $DOTFILE
	done
}

# ---

#
# • MAIN
#

warMachine() {
	systemCheck

	#
	# • HOMEBREW
	#

	if [ $(which brew) ]; then
		echo "✅ • Howbrew"
	else
		remoteScriptInstall https://raw.githubusercontent.com/Homebrew/install/master/install.sh bash
		brew tap homebrew/cask-versions
		brew tap homebrew/cask-fonts
		brew update
	 fi

	#
	# • CORE
	#

	brewInstall zsh tmux
	brewCaskInstall font-hack-nerd-font

	if [ -d $ZSH ]; then
		echo "✅ • Oh-My-Zsh"
	else
		remoteScriptInstall https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	fi

	installDraculaTheme

	#
	# • PROGRAMMING LANGUAGES
	#

	brewInstall rbenv

	if [ -z $RUBY_VERSION ]; then
		RUBY_VERSION=$(rbenv install --list 2>/dev/null | grep -e ^\\d\.\\d\\{1\,2\\}\.\\d\\{1\,2\\}$ | tail -n 1)
	fi

	if [ -e $HOME/.rbenv/versions/$RUBY_VERSION ]; then
		echo "✅ • Ruby $RUBY_VERSION"
	else
		rbenv install $RUBY_VERSION
		rbenv global $RUBY_VERSION
	fi

	if [ ! -e $GOPATH/bin/g ]; then
		remoteScriptInstall https://raw.githubusercontent.com/stefanmaric/g/master/bin/install
	else
		echo "✅ • g (Go Version Manager)"
	fi

	#
	# • DEVELOPMENT
	#

	brewInstall git thefuck
	brewCaskInstall docker

	if [ "$(brew ls vim 2>/dev/null)" ]; then
		echo "✅ • vim"
	else
		brew install vim
	fi

	# - gh

	GH=$ZSH/plugins/gh

	if [ ! -d $GH ]; then
		mkdir $GH
	fi

	if [ ! -e $GH/_gh ]; then
		curl -sSL https://raw.githubusercontent.com/jdxcode/gh/master/zsh/gh/_gh --output $GH/_gh
	fi

	if [ ! -e $GH/gh.plugin.zsh ]; then
		curl -sSL https://raw.githubusercontent.com/jdxcode/gh/master/zsh/gh/gh.plugin.zsh --output $GH/gh.plugin.zsh
	fi

	echo "✅ • gh"

	#
	# • OPERATIONS
	#

	brewInstall man ssh less curl top du lsof watch jq fzf awscli kubernetes-cli the_silver_searcher git-open htop cmake kubectl kubectx kube-ps1

	#
	# • OTHERS
	#

	brewCaskInstall 1password firefox alfred spotify rambox sublime-text keybase

	#
	# • DOTFILES
	#

	if [ ! -d $WAR_MACHINE ]; then
		git clone https://github.com/ammancilla/war_machine.git $WAR_MACHINE
	fi

	if [ ! -d $HOME/.ssh ]; then
		mkdir $HOME/.ssh
	fi

	dotfiles vimrc zshrc tmux.conf ssh/config

	echo "✅ • Dotfiles"

	#
	# • VIM PLUGINS
	#

	VIM_TERRAFORM=$HOME/.vim/pack/plugins/start/vim-terraform

	if [ ! -d $VIM_TERRAFORM ]; then
		git clone https://github.com/hashivim/vim-terraform.git $VIM_TERRAFORM
	fi

}

warMachine

#
# POST INSTALL
#

echo "\n\n📝 POST INSTALL\n"
echo "1. Import Dracula Profile: Terminal APP > Preferences > Profiles > ⚙ > Import (from $HOME/src/github.com/dracula/terminal-app/Dracula.terminal)"
echo "2. Change Dracula Profile Font: Terminal APP > Preferences > Profiles > Dracula > Font Change... > 'Hack Nerd Font'"
