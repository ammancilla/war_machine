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

export ZSH=$HOME/.oh-my-zsh
export CHSH=no
export RUNZSH=no
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
		if [ $(which $formula) ] || [ "$(brew ls $formula &2>/dev/null)" ]; then
			echo "✅ • $formula"
		else
			brew install $formula
		fi
	done
}

function brewCaskInstall {
	for app in $@
	do
		if [ $(which $app) ] || [ "$(brew list --cask $app &>/dev/null)" ] || [ "$(ls /Applications/ | grep -i $app)" ]; then
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
	fi

	if !(brew tap | grep cask-versions &>/dev/null); then
		brew tap homebrew/cask-versions
	fi

	if !(brew tap | grep cask-fonts &>/dev/null); then
		brew tap homebrew/cask-fonts
	fi

	brew update &>/dev/null

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

	brewInstall man ssh less curl top du lsof watch jq fzf awscli the_silver_searcher git-open htop cmake kubectl kubectx stern git-crypt gpg

	#
	# • OTHERS
	#

	brewCaskInstall 1password firefox alfred spotify rambox sublime-text keybase

	#
	# • DOTFILES
	#

	if [ ! -d $WAR_MACHINE ]; then
		git clone https://github.com/ammancilla/war_machine.git $WAR_MACHINE
	else
		echo "\nWould you like to update War Machine? [Y/n] "; read answer

		if [ answer == "Y" ]; then
			cd $WAR_MACHINE && git checkout master && git pull origin/master --rebase
		fi
	fi

	if [ ! -d $HOME/.ssh ]; then
		mkdir $HOME/.ssh
	fi

	dotfiles vimrc zshrc tmux.conf ssh/config gitconfig gitignore tool-versions

	echo "✅ • Dotfiles"

	#
	# • PROGRAMMING LANGUAGES
	#

	brewInstall asdf &

	wait $!

	asdf plugin add ruby
	asdf plugin add elixir
	asdf plugin add erlang
	asdf plugin add nodejs
	asdf plugin add terraform

	asdf install
}

warMachine

#
# POST INSTALL
#

echo "\n\n📝 POST INSTALL\n"
echo "1. Import Dracula Profile: Terminal APP > Preferences > Profiles > ⚙ > Import (from $HOME/src/github.com/dracula/terminal-app/Dracula.terminal)"
echo "2. Change Dracula Profile Font: Terminal APP > Preferences > Profiles > Dracula > Font Change... > 'Hack Nerd Font'"
