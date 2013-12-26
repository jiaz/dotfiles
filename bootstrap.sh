#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" --exclude "init/" -av --no-perms . ~

	ln -fs ~/.zprezto/runcoms/zlogin ~/.zlogin
	ln -fs ~/.zprezto/runcoms/zlogout ~/.zlogout
	ln -fs ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
	ln -fs ~/.zprezto/runcoms/zprofile ~/.zprofile
	ln -fs ~/.zprezto/runcoms/zshenv ~/.zshenv
	ln -fs ~/.zprezto/runcoms/zshrc ~/.zshrc

	echo "Restart the terminal to reload settings."
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
