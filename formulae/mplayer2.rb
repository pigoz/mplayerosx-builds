require 'formula'

class Mplayer2 <Formula
  head 'git://git.mplayer2.org/mplayer2.git', :using => :git
  homepage 'http://mplayer2.org'

  depends_on 'pkg-config' => :build
  depends_on 'libbs2b' => :build
  depends_on 'libass' => :build

  depends_on 'https://raw.github.com/Homebrew/homebrew-dupes/master/freetype.rb'

  depends_on File.join(File.dirname(__FILE__), 'libav.rb') => :build

  def install
    args = ["--prefix=#{prefix}",
            "--cc=clang",
            "--disable-x11",
            "--disable-sdl",
            "--enable-macosx-bundle",
            "--enable-apple-remote"]

    args << "--target=x86_64-Darwin" if MacOS.prefer_64_bit?

    system "./configure", *args
    system "make"
    system "make install"

    # change the binary name to mplayer2
    FileUtils.mv(bin + 'mplayer', bin + 'mplayer2')
  end

  def patches
    Dir.glob(File.join(File.dirname(__FILE__), "patches", "*.{diff,patch}"))
  end
end
