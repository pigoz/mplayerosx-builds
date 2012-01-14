require 'formula'
require File.join(File.dirname(__FILE__), 'ENV.rb')

class Mplayer2 <Formula
  class << self
    def cond_depends_on(path)
      depends_on path => :build if yield
    end

    def in_path?(binary)
      `which #{binary}`.strip != ""
    end
  end

  head 'git://git.mplayer2.org/mplayer2.git', :using => :git
  homepage 'http://mplayer2.org'

  depends_on 'pkg-config' => :build
  depends_on 'libbs2b' => :build
  depends_on 'libass' => :build

  depends_on 'https://raw.github.com/adamv/homebrew-alt/master/' \
             'duplicates/freetype.rb' => :build

  # try to build apple's gcc if it isn't in the path
  cond_depends_on 'https://raw.github.com/adamv/homebrew-alt/master/' \
                  'duplicates/apple-gcc42.rb' do not in_path? 'gcc-4.2' end

  depends_on File.join(File.dirname(__FILE__), 'libav.rb') => :build

  def install
    ENV.local_gcc
    ENV['CC'] = ''
    ENV['LD'] = ''
    ENV['LDFLAGS'] = "-headerpad_max_install_names"
    ENV['CFLAGS'] = ''
    ENV['CXXFLAGS'] = ''

    args = ["--prefix=#{prefix}",
            "--cc=gcc-4.2",
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
