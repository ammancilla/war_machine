#!/usr/bin/env bash

# War Machine - MacOS

#
# • CONFIG
#
set -e

if [ "$TRACE" ]; then
	set -x
fi

if [ "$VERBOSE" ]; then
	set -v
fi

if [ "$DRY_RUN" ]; then
	set -n
fi

if [ "$NO_EXIT_ON_ERROR" ]; then
	unset -e
fi

export ZSH="$HOME/.oh-my-zsh"
export CHSH=no
export RUNZSH=no
export WAR_MACHINE="$HOME/.war_machine"

#
# • FUNCTIONS
#
systemCheck () {
	if [ "$(uname)" != "Darwin" ]; then
		echo "🥴 • Unsupported Operating System"
		exit 1
	fi

	if [ -z "$(which curl)" ]; then
		echo "🥴 • Install curl first"
		exit 1
	fi
}

brewInstall () {
	for formula in "$@"
	do
		if [ "$(which "$formula")" ] || [ "$(brew ls "$formula" 2>/dev/null)" ]; then
			echo "✅ • $formula"
		else
			brew install "$formula"
		fi
	done
}

brewCaskInstall () {
	for app in "$@"
	do
		if [ "$(which "$app")" ] || [ "$(brew list --cask "$app" 2>/dev/null)" ] || [ "$(ls /Applications/ | grep -i "$app")" ]; then
			echo "✅ • $app"
		else
			brew install --cask "$app"
		fi
	done
}

remoteScriptInstall () {
	local shell="${2:-sh}"
	local scriptLocation=$1

	echo "$shell"
	echo "$scriptLocation"

	/usr/bin/env "$shell" -c "$(curl -fsSL "$scriptLocation")"
}

installDraculaTheme () {
	local DRACULA_TERMINAL=$HOME/src/github.com/dracula/terminal-app
	local DRACULA_ZSH=$HOME/src/github.com/dracula/zsh

	if [ -d "$DRACULA_TERMINAL" ]; then
		echo "✅ • Dracula - Terminal APP"
	else
		git clone https://github.com/dracula/terminal-app.git "$DRACULA_TERMINAL"
	fi

	if [ -e "$ZSH/themes/dracula.zsh-theme" ]; then
		echo "✅ • Dracula - ZSH"
	else
		if [ ! -e "$DRACULA_ZSH"  ]; then
			git clone https://github.com/dracula/zsh.git "$DRACULA_ZSH"
		fi

		ln -s "$DRACULA_ZSH/dracula.zsh-theme" "$ZSH/themes/dracula.zsh-theme"
	fi
}

installGh () {
	# - gh (jdxcode/gh)
	GH=$ZSH/plugins/gh

	if [ ! -d "$GH" ]; then
		mkdir "$GH"
	fi

	if [ ! -e "$GH/_gh" ]; then
		curl -sSL https://raw.githubusercontent.com/jdxcode/gh/master/zsh/gh/_gh --output "$GH/_gh"
	fi

	if [ ! -e "$GH/gh.plugin.zsh" ]; then
		curl -sSL https://raw.githubusercontent.com/jdxcode/gh/master/zsh/gh/gh.plugin.zsh --output "$GH/gh.plugin.zsh"
	fi

	echo "✅ • gh"
}

dotfiles () {
	local answer

	for FILE in "$@"
	do
		local DOTFILE=$HOME/.$FILE

		if [ -e "$DOTFILE" ]; then

			printf "Dotfile %s exists, overwrite it? [Y/n] " "$FILE" && read -r answer
			if [ "$answer" == "Y" ]; then
				rm -f "$DOTFILE.warmachine"
				mv "$DOTFILE" "$DOTFILE.warmachine"
				ln -s "$WAR_MACHINE/$FILE" "$DOTFILE"
			fi
		else
			ln -s "$WAR_MACHINE/$FILE" "$DOTFILE"
		fi

	done
}

#
# • MAIN
#
warMachine() {
	systemCheck

	#
	# • HOMEBREW
	#
	if [ "$(which brew)" ]; then
		echo "✅ • Howbrew"
	else
		remoteScriptInstall https://raw.githubusercontent.com/Homebrew/install/master/install.sh bash
	fi

	if ! (brew tap | grep cask-versions &>/dev/null); then
		brew tap homebrew/cask-versions
	fi

	if ! (brew tap | grep cask-fonts &>/dev/null); then
		brew tap homebrew/cask-fonts
	fi

	brew update &>/dev/null

	#
	# • CORE
	#
	brewInstall zsh tmux

	if [ -d "$ZSH" ]; then
		echo "✅ • Oh-My-Zsh"
	else
		remoteScriptInstall https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	fi

	installDraculaTheme
	brewCaskInstall font-hack-nerd-font

	#
	# • SOFTWARE DEVELOPMENT
	#
	installGh
	brewInstall vim git
	brewCaskInstall docker

	#
	# • OPERATIONS
	#
	brewInstall fd bat kap kind thefuck man ssh curl top du lsof watch jq fzf awscli the_silver_searcher git-open htop cmake kubectl kubectx stern git-crypt gpg

	#
	# • DIAGRAMS
	#
	brewCaskInstall drawio ithoughtsx

	#
	# • OTHERS
	#
	brewCaskInstall 1password firefox alfred spotify

	#
	# • DOTFILES
	#
	if [ ! -d "$WAR_MACHINE" ]; then
		git clone https://github.com/ammancilla/war_machine.git "$WAR_MACHINE"
	else
		printf "\nUpdate War Machine? [Y/n] " && read -r answer

		if [ "$answer" == "Y" ]; then
			cd "$WAR_MACHINE" && git checkout master && git pull --rebase
		fi
	fi

	if [ ! -d "$HOME/.ssh" ]; then
		mkdir "$HOME/.ssh"
	fi

	dotfiles vimrc zshrc tmux.conf ssh/config gitconfig gitignore tool-versions dockerignore asdfrc

	printf "\nConfigure your git name and email? [Y/n] " && read -r answer

	if [ "$answer" == "Y" ]; then
		printf "\nName: " && read -r name
		git config --global user.name "$name"

		printf "Email: " && read -r email
		git config --global user.email "$email"
	fi

	echo "✅ • Dotfiles"

	#
	# • PROGRAMMING LANGUAGES
	#
	brewInstall asdf &

	wait $!

	asdf plugin add ruby &>/dev/null
	asdf plugin add elixir &>/dev/null
	asdf plugin add erlang &>/dev/null
	asdf plugin add nodejs &>/dev/null
	asdf plugin add postgres &>/dev/null
	asdf plugin add terraform &>/dev/null

	asdf install
}

warMachine

#
# POST INSTALL
#
printf "\n\n📝 POST INSTALL\n"
echo "1. Import Dracula Profile: Terminal APP > Preferences > Profiles > ⚙ > Import (from $HOME/src/github.com/dracula/terminal-app/Dracula.terminal)"
echo "2. Change Dracula Profile Font: Terminal APP > Preferences > Profiles > Dracula > Font Change... > 'Hack Nerd Font'"
