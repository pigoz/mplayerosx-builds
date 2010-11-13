mplayerosx-builds
=================
mplayerosx-builds is a collection of scripts that I use to compile [mplayer.git](http://repo.or.cz/w/mplayer.git) on the Mac.
This project uses custom [mxcl/homebrew](http://github.com/mxcl/homebrew) formulae for compilation and dependency management.

Where to get binaries now?
--------------------------
The original project is on [Google code](http://code.google.com/p/mplayerosx-builds/): you can use the binaries offered there for the time being. Even if they are built with [mplayer-build.git scripts](http://repo.or.cz/w/mplayer-build.git) and are pretty old they will probably satisfy most users.

Actually, I really wanna build from source
------------------------------------------
Then get XCode, homebrew, clone this project and use my formulae! You can then compile ffmpeg-mt, libass, yasm and mplayer.git by moving to the cloned directory and issuing:

	brew install $PWD/mplayer.rb

Why not push these formulae to homebrew trunk?
----------------------------------------------
mplayer.git is pretty hackish and experimental: it doesn't belong anywhere as a default choice.