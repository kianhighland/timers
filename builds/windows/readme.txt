these are the instructions:
put timers.exe and timer.pck in the same directory
run timers.exe
yay
while using program, if you ever scroll too far in either direction, press home
edit the timer.txt file as you like
rename it if you don't like what it does.
if you would like to color code your timer.txt file, do the following
  use vim
  turn on colorcoding in vim
  put timers.vim in $HOME/vimfiles/syntax (~/.vim/syntax in sygwin)
    $HOME is your home directory
  create $HOME/vimfiles/ftdetect/timers.vim (I think, I don't use windows)
    if you're using sygwin, instead create ~/.vim/ftdetect/timers.vim 
  add the following line to ~/.vim/ftdetect/timers.vim (or the other place)
    au BufRead,BufNewFile timer.txt set filetype=timers
  the syntax is imperfect, but it's not bad
  you're good to go
you can save your times to a file, simply press controll - s
  The file name will be the current date
    If that file already exists and was last modified before this program
        started, _1 will be appended to the file name
      If that already exists, _2 will be appended and so on
  If you forget to save, don't wory, when you close, your times are saved to 
      .times.tmp
    if you need this file, make sure to move it to a new name or location,
        otherwise it will be overwriten the next time you close this program
