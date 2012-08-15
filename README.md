mplayerosx-builds
=================
mplayerosx-builds is a collection of scripts I use to make make Mac OS X
Application Bundles of [mplayer2](http://www.mplayer2.org/).

Originally this project contained custom [mxcl/homebrew](http://github.com/mxcl/homebrew)
formulae for compilation and dependency management, but they have since
then been moved to [pigoz/homebrew-mplayer2](https://github.com/pigoz/homebrew-mplayer2)
to make use of the new tap functionality available in Homebrew 0.9+.

I want to get binaries. Where are they?
---------------------------------------
The binaries are on [Google code](http://code.google.com/p/mplayerosx-builds/).

I want to build from source. What do I do?
------------------------------------------
Head to [pigoz/homebrew-mplayer2](https://github.com/pigoz/homebrew-mplayer2)        

Making Mac OSX Bundles
----------------------
Once you have compiled mplayer2 from source, you can make different types of bundles, they all have a few things in common:

 *  the bundle is created in the `deploy/` directory
 *  the mplayer binary used in the bundle is the first in your path (the one listed by the `which` unix command).

Here is a list of bundles:

 *  `rake pkg:mpb[$version]`: makes a standalone binary `mplayer2.app` that you can drop to your Applications directory. If version is not provided the current date is used.
 *  `rake pkg:mposxt`: makes a mpBinaries bundle that works with MPlayerOSX Extended.

Issues? Comments?
-----------------
If you found some issues with these binaries or have some suggestions please open a ticket on the [Issue Tracker](https://github.com/pigoz/mplayerosx-builds/issues).

Contribute
----------
Send me a pull request for small changes otherwise contact me by mail or IRC.

Contacts
========
Drop me a mail at stefano.pigozzi@gmail.com, [follow me](http://twitter.com/pigoz) on twitter or find me on IRC (pigoz on rizon and freenode)
