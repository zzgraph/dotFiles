#!/usr/bin/env bash

# Install condiguration files for vim, mlterm, bash, tmux and git This
# script trys not to copy or create files as long as possible It
# checks if a configuration file with the same name exists in the Home
# folder (either a softli nk or regular file) the script will move it
# to a backup folder names ~/.rcfiles.backup/ and append its name with
# a datetime.


# GNU readlink utility is used to dtermine if an existing softlink in
# user home directory linked to the same file this install script
# tries to link or is a soft link to an other file, this way the
# script can safely decides to either delete the link or create a back
# up

if [[ ! $(which readlink 2>/dev/null) ]]; then
    echo "This script needs readlink command to perform";
    echo "Please install readlink, it is part of gnu coreutils packge";
    exit 1;
fi

# Check if backup folder is already created, if not creting it
if [[ ! -d $HOME/.rcfiles.backup ]]; then
   mkdir $HOME/.rcfiles.backup/;
fi

# I use jalali calander for datetime if available
if [[ $(which jdate 2>/dev/null) ]]; then
    dateCmd=jdate;
else
    dateCmd=date;
fi

function checkInstallConfig () {


    # usage: this function accepts four arguments first argument is an
    # array consist of names of files or durectoies in current working
    # directory, second argument especifies if list consistes of
    # directories if "true" it assumes list contains just directory
    # names and checks home folder if the directories with the same
    # name exist, else it assume list contains files, checks if those
    # file with the same name exist (if forth argument is set to non
    # empty string) it prepend a dot in front of file names and if
    # third argument is set to non empty string, it will use that
    # string as the neme of subdirectory search a subdirectory inside
    # home directory for configuration files.  finally whatever files
    # whit the same name (in subdirectory if specified or prepended
    # with dot if specified) this function findes, it will copy them
    # to a directory named .rcfiles.backup inside home directory and append
    # the name with a datetime
    local oldConfig="$1[@]";
    local hasDot="$4";
    local from=$PWD/"$2";
    local to=$HOME/"$3";
    local isExecutable="$5"

    if [[ $hasDot == "true" ]]; then
	Dot=".";
    else
	Dot="";
    fi;

    if [[ $isExecutable == "true" ]]; then
	mode=775;
    else
	mode=664;
    fi

    for y in ${!oldConfig}; do
	local cF=$to/$Dot$y
	# Check if destination file exist an is a symbolic link
	if [[  -h $cF ]]; then
	    echo "$cF is exists an is a symbolic link";
	    local symLink=$(readlink $cF);
	    local actFile=$(find $from -name $y)
	    if [[ $symLink == $actFile ]]; then
		echo "$cF is a symbolic link to the same configuration file you try to install";
		echo "I remove your $Dot$y to create a new file";
		rm $cF;
		install $from/$y $cF --backup=existing --suffix=.back.$(date +%Y-%m-%d_%H:%M:%S) -C -D -v --mode=$mode;
	    else
		echo "$cF is a symlink to another configuration file I will create a backup of it in $HOME/.rcfiles.backup/ folder"
		mv $cF $HOME/.rcfiles.backup/$y.back.$($dateCmd +%Y-%m-%d_%H:%M:%S);
		install $from/$y $cF --backup=existing --suffix=.back.$(date +%Y-%m-%d_%H:%M:%S) -C -D -v --mode=$mode;
	    fi

	elif [[ -e $cF && -f $cF && ! -h $cF || -d $cF ]]; then

	    echo "Your previous version of $Dot$y seems to be an actual file, I create a backup of it right ther in your home directory";
	    echo "It has been renamed to $cF.back$($dateCmd +%Y-%m-%d_%H:%M:%S)";
	    install $from/$y $cF --backup=existing --suffix=.back.$(date +%Y-%m-%d_%H:%M:%S) -C -D -v --mode=$mode;

        else
	    echo "It does not seem to be any previous version of $Dot$y in your home folder";
	    install $from/$y $cF --backup=existing --suffix=.back.$(date +%Y-%m-%d_%H:%M:%S) -C -D -v --mode=$mode;
	fi;
	for i in $(find $to -maxdepth 1 -type f -name $y.back* ); do
	    if [[ -n $i ]]; then
		mv $i $HOME/.rcfiles.backup/;
	    fi
	done
    done;

};


# Configuration files which we should prepend their name with dot and
# install in home folder

declare -a configFiles=(
    "bashrc"
    "vimrc"
    "dir_colors"
    "bash_profile"
    "gitconfig"
    "tmux.conf"
    "gitignore_global"
)

# check if platform is Cygwin and install .minttyrc
if [[ $(uname -o) == Cygwin ]]; then
    configFiles+=" minttyrc";
fi

checkInstallConfig configFiles "" "" "true" "false"


# declare -a noDotConfig=(
# )

# checkInstallConfig noDotConfig "flase" "" "false" "false"


declare -a binFiles=(
    "emc"
)

checkInstallConfig binFiles "bin" "bin" "false" "true"

declare -a mltermConfig=(
    "aafont"
    "color"
    "font"
    "key"
    "main"
    "taafont"
    "vaafont"
)

checkInstallConfig mltermConfig "mlterm" ".mlterm" "false" "false"

declare -a bashRcConfig=(
    "aliases"
    "functions"
    "git-prompt"
    "ngCompletion"
    "npmCompletion"
    "paths"
    "prompt"
)

checkInstallConfig bashRcConfig "bashrc.d" ".bashrc.d" "false" "false"

declare -a vimBundle=(
    "commentary"
    "fugitive"
    "gruvbox"
    "happy_hacking.vim"
    "jellybeans"
    "lightline"
    "lightline-gruvbox"
    "mlterm-syntax"
    "papercolor"
    "solarized8"
    "tender-colorscheme"
    "vim-pathogen"
    "vorange"
    "wombat256"
    "zenburn"
)

for vim in ${vimBundle[@]}; do
    declare bundleFiles1=($(ls $PWD/vim/bundle/$vim/plugin 2>/dev/null));
    declare bundleFiles2=($(ls $PWD/vim/bundle/$vim/doc 2>/dev/null));
    declare bundleFiles3=($(ls $PWD/vim/bundle/$vim/colors 2>/dev/null));
    declare bundleFiles4=($(ls $PWD/vim/bundle/$vim/autoload 2>/dev/null));

    if [[ -n $bundleFiles1 ]]; then
	checkInstallConfig bundleFiles1 "vim/bundle/$vim/plugin" ".vim/bundle/$vim/plugin" "false" "false";
    elif [[ -n $bundleFiles2 ]]; then
	checkInstallConfig bundleFiles2 "vim/bundle/$vim/doc" ".vim/bundle/$vim/doc" "false" "false";
    elif [[ -n $bundleFiles3 ]]; then
	checkInstallConfig bundleFiles3 "vim/bundle/$vim/colors" ".vim/bundle/$vim/color" "false" "false";
    elif [[ -n $bundleFiles4 ]]; then
	checkInstallConfig bundleFiles4 "vim/bundle/$vim/autoload" ".vim/bundle/$vim/color" "false" "false";
    fi
done

exit 0;
