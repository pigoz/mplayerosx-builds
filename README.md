mplayerosx-builds
=================
mplayerosx-builds is a collection of scripts that I use to compile [mplayer2](http://www.mplayer2.org/) on the Mac.
This project uses custom [mxcl/homebrew](http://github.com/mxcl/homebrew) formulae for compilation and dependency management.

Where to get binaries now?
--------------------------
The binaries are on [Google code](http://code.google.com/p/mplayerosx-builds/). The rest of project (i.e.: scripts for producing the binaries, wiki articles, etc) is in the process of being moved to this GitHub project.

Actually, I really wanna build from source
------------------------------------------
If you are familiar with homebrew you can use my formulae directly; otherwise you can use the provided rake task:

    git clone -b master git://github.com/pigoz/mplayerosx-builds.git
    cd mplayerosx-builds
    rake install

After a while your mplayer2 will be compiled, installed to the Cellar and symlinked to `/usr/local/bin`.
If you already installed mplayer2 and libav through `rake install`, and you want to upgrade your installation to the current git HEAD, run `rake upgrade`.

Making Mac OSX Bundles
----------------------
You can make different types of bundles, they all have a few things in common:

 *  the bundle is created in the `deploy/` directory
 *  the mplayer binary used in the bundle is the first in your path (the one listed by the `which` unix command).

Here is a list of bundles:

 *  `rake pkg:mpb[$version]`: makes a standalone binary `mplayer2.app` that you can drop to your Applications directory. If version is not provided the current date is used.
 *  `rake pkg:mposxt`: makes a mpBinaries bundle that works with MPlayerOSX Extended.

Why not push these formulae to homebrew?
----------------------------------------------
I do a lot of thinkering with these formulae so I like to have them in a repository where I have full control.

Issues? Comments?
-----------------
If you found some issues with these binaries or have some suggestions please open a ticket on the [Issue Tracker](https://github.com/pigoz/mplayerosx-builds/issues).

Contribute
----------
Send me a pull request for small changes otherwise contact me by mail or IRC.

Contacts
========
Drop me a mail at stefano.pigozzi@gmail.com, [follow me](http://twitter.com/pigoz) on twitter or find me on IRC (pigoz on rizon and freenode)
