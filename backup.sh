# !/bin/bash
function is_dir(){
	[ -d "$1" ]
}


function illegal_argument_err(){
	echo "illegal argument $1"
	echo "Usage:"
	echo "    --git: to auto commit"
}


function prepare_dirs(){
	declare -a dirs_needed=(
		"$tmp_path"
		"$tmp_path/shell"
		"$tmp_path/vim"
		"$tmp_path/iterm"
		"$tmp_path/git"
        "$tmp_path/function"
        "$tmp_path/system"
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
			"shell_config"
		)

	for f in "${shell_sup_files[@]}"; do
		if [ -f "$HOME/.shell/.${f}" ]; then 
			cp "$HOME/.shell/.${f}" $tmp_path/shell/$f
			echo "[OK]... ${f}"
		fi
	done

	unset shell_sup_files

    # function files
    if [ -d "$HOME/.fucntion" ]; then
        cp -R "$HOME/.function/." "$tmp_path/function/"
        echo "[OK]... all files in .function"
    else
        echo "[SKIP]... .function/ not exist."
    fi


    # system config
	if [ -d "$HOME/.sys" ]; then
        cp -R "$HOME/.sys/." "$tmp_path/system/"
        echo "[OK]... all files in .sys"
    else
        echo "[SKIP]... .sys/ not exist."
    fi


	# Vim files
    cp "$HOME/.vimrc" "$tmp_path/vim/vimrc"
    echo "[OK]... vimrc"


    # TODO: git

}


function cp_to_repo(){

    if [ -d "$tmp_path" ]; then
        mv -f "$tmp_path" "$dotfile_path/dotfiles"
        echo "Move all files to $dotfile_path"
    fi
}

fucntion do_auto_git(){
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
  	git commit -m "sync dotfiles at ${ts}"
  	echo "[OK]... auto commit"
}


function main(){

	# Check arguments
    is_auto_git=false

    while [ "$1" != "" ];do
    	case $1 in

    		--git )		is_auto_git=true ;;

			* ) 		illegal_argument_err $1
						return ;;

		esac
		shift
	done

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


	if $is_auto_git ; then
		do_auto_git
	fi
}


main "$@"
