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
    local isFolder="$2";
    local hasDot="$4";
    local whichFolder="$3";
    local folderIsDotFolder="$5";

    if [[ $hasDot == "true" ]]; then
	Dot=".";
    else
	Dot="";
    fi;

    if [[ $folderIsDotFolder == "true" ]]; then
	Df=".";
    else
	Df="";
    fi;

    

    if [[ $isFolder == "true" ]]; then
	for j in ${!oldConfig}; do
	    local cD=$HOME/$Df$whichFolder$Dot$j;
	    if [[ -e $cD && -d $cD ]]; then
		echo "$cD already folder exists, using existing folder";
	    else
		echo "$Df$whichFolder$j folder does not exist in your home directory";
		mkdir $cD;
		echo "$cD created."
	    fi
	done
    

    else
	for y in ${!oldConfig}; do
	    local cF=$HOME/$Df$whichFolder$Dot$y
	    # Check if destination file exist an is a symbolic link
	    if [[  -h $cF ]]; then
		echo "$cF is exists an is a symbolic link";
		local symLink=$(readlink $cF);
		local actFile=$(find $(pwd)/$whichFolder -name $y)
		if [[ $symLink == $actFile ]]; then
		    echo "$cF is a symbolic link to the same configuration file you try to install";
		    echo "I remove your $Dot$y to create a new symlink";
		    rm $cF;
		    ln -s $PWD/$whichFolder$y $cF;
		    echo "$cF is created in your home directory"
		else
		    echo "$cF is a symlink to another configuration file I will create a backup of it in $HOME/.rcfiles.backup/ folder"
		    mv $cF $HOME/.rcfiles.backup/$y.back.$($dateCmd +%Y-%m-%d_%H:%M:%S);
		    ln -s $PWD/$whichFolder$y $cF;
		    echo "$cF is created in your home directory"
		fi

	    elif [[ -e $cF && -f $cF && ! -h $cF || -d $cF ]]; then

		echo "Your previous version of $Dot$oldConfig seems to be an actual file, I create a backup of it right ther in your home directory";
		echo "It has been renamed to $HOME/$cF.back$($dateCmd +%Y-%m-%d_%H:%M:%S)";
		mv $cF $HOME/$y.back.$($dateCmd +%Y-%m-%d_%H:%M:%S);

            else
		echo "It does not seem to be any previous version of $Dot$y in your home folder";
		echo "It is safte to create new symlink to $cF";
		ln -s $PWD/$whichFolder$y $cF;
		echo "$cF is created in your home directory"
	    fi;
	done;
    fi
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
)

# check if platform is Cygwin and install .minttyrc
if [[ $(uname -o) == Cygwin ]]; then
    configFiles+=" minttyrc";
fi

checkInstallConfig configFiles "flase" "" "true" "false"


# declare -a noDotConfig=(
# )

# checkInstallConfig noDotConfig "flase" "" "false" "false"

declare -a folderConfig=(
    "bin"
)

checkInstallConfig folderConfig "true" "" "false" "false"

declare -a dotFolderConfig=(
    "bashrc.d"
    "vim"
    "mlterm"
)

checkInstallConfig dotFolderConfig "true" "" "true" "false"

declare -a binFiles=(
    "emc"
)

checkInstallConfig folderConfig "false" "bin/" "false" "false"

declare -a mltermConfig=(
    "aafont"
    "color"
    "font"
    "key"
    "main"
    "taafont"
    "vaafont"
)

checkInstallConfig mltermConfig "false" "mlterm/" "false" "true"

declare -a bashRcConfig=(
    "aliases"
    "functions"
    "git-prompt"
    "ngCompletion"
    "npmCompletion"
    "paths"
    "prompt"
)

checkInstallConfig bashRcConfig "false" "bashrc.d/" "false" "true"

declare -a vimBundle=(
    "bundle"
)

checkInstallConfig vimBundle "false" "vim/" "false" "true"
exit 0;
