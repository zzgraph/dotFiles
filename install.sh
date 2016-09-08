if [ -e $HOME/.vimrc ]; then
    echo "Your previous vim configuration file "$HOME"/.vimrc \
has been renamed to "\
$HOME"/.vimrc.back".$(date +%Y-%m-%d_%H:%M:%S);
    
    mv $HOME/.vimrc $HOME/.vimrc.back.$(date +%Y-%m-%d_%H:%M:%S)
fi

if [ -d $HOME/.vim ] && [ -d $HOME/.vim ]; then
    echo "Your previous vim configuration file "$HOME"/.vim \
    	 has bee renamed to "\
	 $HOME"/.vim.back."$(date +%Y-%m-%d_%H:%M:%S);
    
    mv $HOME/.vim $HOME/.vim.back.$(date +%Y-%m-%d_%H:%M:%S)
fi

cp ./vimrc ~/.vimrc
cp -r ./vim/ ~/.vim
