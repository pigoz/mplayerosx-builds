mplayerosx-builds
=================
mplayerosx-builds is a collection of scripts that I use to compile [mplayer.git](http://repo.or.cz/w/mplayer.git) on the Mac.
This project uses custom [mxcl/homebrew](http://github.com/mxcl/homebrew) formulae for compilation and dependency management.

Where to get binaries now?
--------------------------
The original project is on [Google code](http://code.google.com/p/mplayerosx-builds/): you can use the binaries offered there for the time being. Even if they are built with [mplayer-build.git scripts](http://repo.or.cz/w/mplayer-build.git) and are pretty old they will probably satisfy most users.

Actually, I really wanna build from source
------------------------------------------
If you are familiar with homebrew you can use my formulae directly; otherwise you can use the provided rake task:

	git clone git://github.com/pigoz/mplayerosx-builds.git
	cd mplayerosx-builds && rake build

Why not push these formulae to homebrew master?
----------------------------------------------
mplayer.git is an unofficial fork of the original mplayer which alredy has an homebrew formula. I think that having this in homebrew trunk would only lead to confusion in the end users.