require 'formula'

class Mplayer <Formula
  head 'git://repo.or.cz/mplayer.git', :using => :git
  homepage 'http://repo.or.cz/w/mplayer.git'

  depends_on 'pkg-config' => :build
  depends_on 'libass' => :build
  depends_on File.join(File.dirname(__FILE__),'ffmpeg.rb') => :build

  def install
    ENV.gcc_4_2
    ENV['CC'] = ''
    ENV['LD'] = ''
    ENV['CFLAGS'] = ''
    ENV['CXXFLAGS'] = ''
    
    args = ["--prefix=#{prefix}", "--cc=gcc-4.2", "--enable-largefiles", 
            "--disable-x11", "--disable-gl",
            "--enable-apple-remote", "--enable-macosx-bundle",
            "--enable-macosx-finder"]
    
    args << "--target=x86_64-Darwin" if snow_leopard_64?
    
    system "./configure", *args
    system "make"
    system "make install"
  end
end
