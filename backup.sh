# !/bin/bash
function is_dir(){
	[ -d "$1" ]
}


function prepare_dirs(){
	declare -a dirs_needed=(
		"$HOME/.dotfiles"
		"$HOME/.dotfiles/shell"
		"$HOME/.dotfiles/vim"
		"$HOME/.dotfiles/iterm"
		"$HOME/.dotfiles/git"
        "$HOME/.dotfiles/shell/custom"
		)

	for d in "${dirs_needed[@]}"; do
		if ! is_dir "$d" ; then
			mkdir $d
			echo 'create directory: '${d}
		fi
	done

	unset dirs_needed
}

function cp_all_dotfiles(){
	
	# prepare all dirs needed
	prepare_dirs


	# Shell files 
	cp $HOME/.zshrc $HOME/.dotfiles/shell/zshrc
	echo "[OK]... zshrc"

	declare -a shell_sup_files=(
			"shell_exports"
			"shell_alias"
			"shell_functions"
			"shell_config"
		)

	for f in "${shell_sup_files[@]}"; do
		if [ -f "$HOME/.shell/.${f}" ]; then 
			cp "$HOME/.shell/.${f}" $HOME/.dotfiles/shell/$f
			echo "[OK]... ${f}"
		fi
	done

	unset shell_sup_files

    # Custom shell files
    if [ -d "$HOME/.shell/custom" ]; then
        cp -R "$HOME/.shell/custom/." "$HOME/.dotfiles/shell/custom/"
        echo "[OK]... all files in .shell/custom"
    else
        echo "[SKIP]... .shell/custom/ not exist."
    fi

	# Vim files
    cp "$HOME/.vimrc" "$HOME/.dotfiles/vim/"
    echo "[OK]... vimrc"

}


function cp_to_repo(){
    if [ -d "$HOME/.dotfiles" ]; then
        mv -fi -v "$HOME/.dotfiles/" "$dotfile_path/dotfiles"
        echo "Move all files to $dotfile_path"
    fi
}


function main(){

    # Remember the dotfile folder path.
    dotfile_path=$(pwd)
    echo $dotfile_path

	# cd to HOME
	cd $HOME

	# copy all file to a temparay folder
	cp_all_dotfiles

	# copy tmp filder to repo
	cp_to_repo
	
	# cd to repo
	cd $dotfile_path

	# init git
	if ! [ -d .git ]; then 
	 	git init
	fi

	# auto add, auto commit
	git add --all

    ts=$(date "+%Y%m%d_%H:%M:%S")
  	git commit -m "auto sync dotfiles at ${ts}"
}


main
