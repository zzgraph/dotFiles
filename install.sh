for configFile in {.bashrc,.vimrc,.dir_colors,.vim}; do
if [ -h $HOME/$configFile ]; then

echo "Removing previously linked configuration files to create a new link";
rm $HOME/$configFile;

elif [ -e $HOME/$configFile ] || [ -d $HOME/configFile ]; then

echo "Your previous vim configuration file "$HOME"/"$configFile \
"has been renamed to "\
$HOME"/"$configFile".back"$(date +%Y-%m-%d_%H:%M:%S);
  
mv $HOME/$configFile $HOME/$configFile.back.$(date +%Y-%m-%d_%H:%M:%S);

	fi;
	done

ln -s $PWD/LS_COLORS/LS_COLORS $HOME/.dir_colors
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/vim/ $HOME/.vim
ln -s $PWD/bashrc $HOME/.bashrc
