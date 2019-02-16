#!/bin/bash

if [ -f ~/.gitconfig.local ]; then
	(>&2 echo "WARNING: Local Gitconfig exists!" )
	(>&2 cat ~/.gitconfig.local)
	echo -n "Do you wish to overwrite your local configuration [y/n]:"
	read -r response

	if [[ $response == [nN] ]]; then
		exit;
	fi;

	less ~/.gitconfig.local >> ~/.gitconfig.local.bak
	rm -f ~/.gitconfig.local

fi;

while [ -z "$email" ]; do
	echo -n "What email address will you be using? : "
	read -r email
done


while [ -z "$name" ]; do
	echo -n "What name do you want to use? : "
	read -r name
done


echo -n "What editor do you want as your default? [nano]:"
read -r editor

if [ -z "$editor" ]; then
	editor="nano"
fi;

echo "
Adding the following defaults
{
	[user]
		email = $email
		name = $name
	[core]
		editor = $editor
	[credential]
		helper = osxkeychain
}
"

echo -n "Looks good? [y/n]:"
read -r  confirm

if [[ $confirm == [yY] ]]; then
# # Let's create a git config for your new system
echo "
[user]
	email = $email
	name = $name
[core]
	editor = $editor
[credential]
	helper = osxkeychain
" > ~/.gitconfig.local

fi;






