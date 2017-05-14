declare -a configFiles=(
    "bashrc"
    "vimrc"
    "dir_colors"
    "vim"
    "bash_profile"
    "bashrc.d"
    "mlterm"
    "gitconfig"
    "tmux.conf"
)
declare -a noDotConfig=(
    "bin"
)



for j in ${!configFiles[*]}; do
    if [ -h $HOME/.${configFiles[$j]} ]; then
        echo "Moving previously linked configuration files to $HOME/rcfiles.backup and create a new link";
        if [ ! -d $HOME/.rcfiles.backup ]; then
            mkdir $HOME/.rcfiles.backup;
        fi
        mv $HOME/.${configFiles[$j]} $HOME/.rcfiles.backup/${configFiles[$j]}.back.$(date +%Y-%m-%d_%H:%M:%S);

    elif [ -e $HOME/.${configFiles[$j]} ] || [ -d $HOME/.${configFiles[$j]} ]; then

        echo "Your previous configuration file $HOME/.${configFiles[$j]}";
        echo "has been renamed to $HOME/${configFiles[$j]}.back$(date +%Y-%m-%d_%H:%M:%S)";

        if [ ! -d $HOME/.rcfiles.backup ]; then
            mkdir $HOME/.rcfiles.backup;
        fi
        mv $HOME/.${configFiles[$j]} $HOME/.rcfiles.backup/${configFiles[$j]}.back.$(date +%Y-%m-%d_%H:%M:%S);

    fi;
done

for j in ${!noDotConfig[*]}; do
    if [ -h $HOME/${noDotConfig[$j]} ]; then
        echo "Moving previously linked configuration files to $HOME/rcfiles.backup and create a new link";
        if [ ! -d $HOME/.rcfiles.backup ]; then
            mkdir $HOME/.rcfiles.backup;
        fi
        mv $HOME/${noDotConfig[$j]} $HOME/.rcfiles.backup/${noDotConfig[$j]}.back.$(date +%Y-%m-%d_%H:%M:%S);

    elif [ -e $HOME/${noDotConfig[$j]} ] || [ -d $HOME/${noDotConfig[$j]} ]; then

        echo "Your previous configuration file $HOME/.${noDotConfig[$j]}";
        echo "has been renamed to $HOME/${noDotConfig[$j]}.back$(date +%Y-%m-%d_%H:%M:%S)";

        if [ ! -d $HOME/.rcfiles.backup ]; then
            mkdir $HOME/.rcfiles.backup;
        fi
        mv $HOME/${noDotConfig[$j]} $HOME/.rcfiles.backup/${noDotConfig[$j]}.back.$(date +%Y-%m-%d_%H:%M:%S);

    fi;
done

for i in ${!configFiles[*]}; do
    echo "Linking new configuration file ${configFiles[$i]} to your home directory";
    ln -s $PWD/${configFiles[$i]} $HOME/.${configFiles[$i]};
done

for i in ${!noDotConfig[*]}; do
    echo "Linking new configuration file ${noDotConfig[$i]} to your home directory";
    ln -s $PWD/${noDotConfig[$i]} $HOME/${noDotConfig[$i]};
done

# check if platform is Cygwin and install .minttyrc
if [ $(uname -o)==Cygwin ]; then
    ln -s $PWD/minttyrc $HOME/.minttyrc
fi
