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
    
    mv $HOME/.vim $HOME/.vim.back.$(date +%Y-%m-%d_%H:%M:%S);
fi

if [ -e $HOME/.dir_colors]; then
    echo "Your previous vim configuration file "$HOME"/.dir_colors \
has been renamed to "\
$HOME"/.dir_colors.back".$(date +%Y-%m-%d_%H:%M:%S);

    mv $HOME/.dir_colors $HOME/.dir_colors.back.$(date +%Y-%m-%d_%H:%M:%S);
fi

if [ -e $HOME/.bshrc ]; then
    echo "Your previous vim configuration file "$HOME"/.bshrc \
has been renamed to "\
$HOME"/.bshrc.back".$(date +%Y-%m-%d_%H:%M:%S);
    
    mv $HOME/.bshrc $HOME/.bashrc.back.$(date +%Y-%m-%d_%H:%M:%S)
fi


ln -s ./LS_COLORS/LS_COLORS ~/.dir_colors
ln -s ./vimrc $HOME/.vimrc
ln -s ./vim/ $HOME/.vim
ln -s ./bashrc $HOME/.bashrc
