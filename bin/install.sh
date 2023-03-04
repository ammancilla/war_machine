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

declare -A dotfiles=( ["starship.toml"]="$HOME/.config/starship.toml" )

#
# • FUNCTIONS
#
printcheck () {
	printf "\n✅ %s" "$1"
}

systemCheck () {
	if [ "$(uname)" != "Darwin" ]; then
		echo "🥴 Unsupported Operating System"
		exit 1
	fi

	if [ -z "$(which curl)" ]; then
		echo "🥴 Install curl first"
		exit 1
	fi
}

brewInstall () {
	for formula in "$@"
	do
		if [ "$(which "$formula")" ] || [ "$(brew ls "$formula" 2>/dev/null)" ]; then
			printcheck "$formula"
		else
			brew install "$formula"
		fi
	done
}

brewCaskInstall () {
	for app in "$@"
	do
		if [ "$(brew list --cask "$app" 2>/dev/null)" ] || [ "$(ls "/Applications/" | grep -i "$app")" ]; then
			printcheck "$app"
		else
			brew install --cask "$app"
		fi
	done
}

remoteScriptInstall () {
	local shell="${2:-sh}"
	local scriptLocation="$1"

	echo "$shell"
	echo "$scriptLocation"

	/usr/bin/env "$shell" -c "$(curl -fsSL "$scriptLocation")"
}

installDraculaTheme () {
	local DRACULA_TERMINAL=$HOME/src/github.com/dracula/terminal-app
	local DRACULA_ZSH=$HOME/src/github.com/dracula/zsh

	if [ -d "$DRACULA_TERMINAL" ]; then
		printcheck "Dracula - Terminal APP"
	else
		git clone https://github.com/dracula/terminal-app.git &>/dev/null "$DRACULA_TERMINAL"
	fi

	if [ -e "$ZSH/themes/dracula.zsh-theme" ]; then
		printcheck "Dracula - ZSH"
	else
		if [ ! -e "$DRACULA_ZSH"  ]; then
			git clone https://github.com/dracula/zsh.git &>/dev/null "$DRACULA_ZSH"
		fi

		ln -s "$DRACULA_ZSH/dracula.zsh-theme" "$ZSH/themes/dracula.zsh-theme"
	fi
}

installGh () {
	# - gh (jdxcode/gh)
	GH="$ZSH/plugins/gh"

	mkdir -p "$GH"

	if [ ! -e "$GH/_gh" ]; then
		curl -sSL https://raw.githubusercontent.com/jdxcode/gh/master/zsh/gh/_gh --output "$GH/_gh"
	fi

	if [ ! -e "$GH/gh.plugin.zsh" ]; then
		curl -sSL https://raw.githubusercontent.com/jdxcode/gh/master/zsh/gh/gh.plugin.zsh --output "$GH/gh.plugin.zsh"
	fi

	printcheck "gh"
}

installZshCustomPlugin () {
	local username="$1"
	local repo_name="$2"
	local local_repo="$HOME/src/github.com/$username/$repo_name"
	local github_repo="https://github.com/$username/$repo_name"
	local zsh_plugin="$ZSH/custom/plugins/$repo_name"

	if [ ! -e "$local_repo" ]; then
		git clone "$github_repo" &>/dev/null "$local_repo"
	fi

	if [ ! -e "$zsh_plugin" ]; then
		ln -s "$local_repo" "$zsh_plugin"
	fi
}

dotfile () {
	local name="$1"
	local file="${dotfiles[$name]}"

	if [ -z "$file" ]; then
		file="$HOME/.$name"
	fi

	echo "$file"
}

dotfiles () {
	local file
	local answer
	local war_machine_file="$WAR_MACHINE/$name"
	local diff_exit_code

	for name in "$@"
	do
		file="$(dotfile "$name")"
		diff_exit_code=
	       	war_machine_file="$WAR_MACHINE/$name"

		if [ -e "$file" ]; then
			diff "$file" "$war_machine_file" &>/dev/null || diff_exit_code=$?

			if [ "$diff_exit_code" = "1" ]; then
				printf "\n🗃️  File %s exists...\n" "$file "
				delta -s "$file" "$war_machine_file" || true
				printf "\nReplace it? [Y/n] "
				read -r answer
				if [ "$answer" == "Y" ]; then
					mv "$file" "$file.warmachine"
					cp "$war_machine_file" "$file"
				fi
			else
				printf "\n🗃️  File %s exists, skipping." "$file"
			fi

		else
			printf "\n🗃️  File %s added." "$file"
			cp "$war_machine_file" "$file"
		fi
	done
}

#
# • MAIN
#
warMachine() {
	systemCheck

	if [ -e "$WAR_MACHINE" ]; then
		cd "$WAR_MACHINE" && git checkout master &>/dev/null && git pull --rebase &>/dev/null
	else
		git clone https://github.com/ammancilla/war_machine.git &>/dev/null "$WAR_MACHINE"
	fi

	#
	# • HOMEBREW
	#
	if [ "$(which brew)" ]; then
		printcheck "Howbrew"
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
	brewInstall zsh tmux starship

	if [ -d "$ZSH" ]; then
		printcheck "Oh-My-Zsh"
	else
		remoteScriptInstall https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	fi

	installZshCustomPlugin zsh-users zsh-autosuggestions
	installZshCustomPlugin zsh-users zsh-syntax-highlighting
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
	brewInstall fd bat kap git-delta thefuck man ssh curl du lsof watch jq fzf ripgrep git-open htop cmake git-crypt gpg

	# - Linters
	brewInstall shellcheck shfmt checkov yamllint hadolint checkmake

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
	printf "\n\nDOTFILES"
	printf "\n--------\n"

	mkdir -p "$HOME/.ssh"
	mkdir -p "$HOME/.config"

	dotfiles vimrc zshrc tmux.conf ssh/config gitconfig gitignore tool-versions dockerignore asdfrc starship.toml

	printf "\n\nGIT"
	printf "\n--------\n"

	read -rp "Configure your git name and email? [Y/n] " answer

	if [ "$answer" == "Y" ]; then
		read -rp "Name: " name
		git config --global user.name "$name"

		read -rp "Email: " email
		git config --global user.email "$email"
	fi

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
echo "2. Change Dracula Profile Font: Terminal APP > Preferences > Profiles > Dracula > Font Change... > 'RHack Nerd Font'"
