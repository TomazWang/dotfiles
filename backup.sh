# !/bin/bash
function is_dir(){
	[ -d "$1" ]
}


function prepare_dirs(){
	declare -a dirs_needed=(
		"$tmp_path"
		"$tmp_path/shell"
		"$tmp_path/vim"
		"$tmp_path/iterm"
		"$tmp_path/git"
        "$tmp_path/shell/custom"
		)

	for d in "${dirs_needed[@]}"; do
		if ! is_dir "$d" ; then
			mkdir $d
			echo '[OK]... create tmp dir: '${d}
		fi
	done

	unset dirs_needed
}

function cp_all_dotfiles(){
	
	# prepare all dirs needed
	prepare_dirs


	# Shell files 
	cp $HOME/.zshrc $tmp_path/shell/zshrc
	echo "[OK]... zshrc"

	declare -a shell_sup_files=(
			"shell_exports"
			"shell_alias"
			"shell_functions"
			"shell_config"
		)

	for f in "${shell_sup_files[@]}"; do
		if [ -f "$HOME/.shell/.${f}" ]; then 
			cp "$HOME/.shell/.${f}" $tmp_path/shell/$f
			echo "[OK]... ${f}"
		fi
	done

	unset shell_sup_files

    # Custom shell files
    if [ -d "$HOME/.shell/custom" ]; then
        cp -R "$HOME/.shell/custom/." "$tmp_path/shell/custom/"
        echo "[OK]... all files in .shell/custom"
    else
        echo "[SKIP]... .shell/custom/ not exist."
    fi

	# Vim files
    cp "$HOME/.vimrc" "$tmp_path/vim/vimrc"
    echo "[OK]... vimrc"

}


function cp_to_repo(){

    if [ -d "$tmp_path" ]; then
        mv -f "$tmp_path" "$dotfile_path/dotfiles"
        echo "Move all files to $dotfile_path"
    fi
}


function main(){

	echo ">> Process begin"

    # declare a tmp folder
    tmp_path="$HOME/.dotfile_tmp"
    
    # Remember the dotfile folder path.
    dotfile_path=$(pwd)
    echo ""
    echo ">>> Current dotfile folder is: $dotfile_path"

	# cd to HOME
	cd $HOME

	# copy all file to a temparay folder
	echo ""
	echo ">>> Copy all files to temparay folder"

	cp_all_dotfiles


	# copy tmp filder to repo
	echo ""
	echo ">>> Move tmp folder to dotfile folder"
	cp_to_repo
	
	# cd to repo
	cd $dotfile_path

	echo ""
	echo ">>> Git Process"
	# init git
	if ! [ -d .git ]; then 
	 	git init
	 	echo "[OK]... init git"
	fi

	# auto add, auto commit
	git add --all
	echo "[OK]... add all files to index"

    ts=$(date "+%Y%m%d_%H:%M:%S")
  	git commit -m "auto sync dotfiles at ${ts}"
  	echo "[OK]... auto commit"
}


main
