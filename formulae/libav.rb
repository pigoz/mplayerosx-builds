require 'formula'

class Libav <Formula
  head 'git://repo.or.cz/FFMpeg-mirror/mplayer-patches.git',
       :using => :git, :branch => 'libav'
  homepage 'http://www.libav.org/'

  depends_on 'pkg-config' => :build
  depends_on 'yasm' => :build

  def install
    ENV.gcc_4_2
    ENV['CC'] = ''
    ENV['LD'] = ''
    ENV['CFLAGS'] = ''
    ENV['CXXFLAGS'] = ''

    args = ["--prefix=#{prefix}",
            "--enable-gpl",
            "--enable-nonfree",
            "--disable-indev=jack",
            "--disable-debug",
            "--enable-pthreads",
            "--enable-shared",
            "--enable-postproc",
            "--disable-devices",
            "--disable-ffmpeg",
            "--disable-avplay",
            "--disable-avserver",
            "--disable-avprobe",
            "--disable-vaapi"]

    args << "--arch=x86_64" if snow_leopard_64?

    system "./configure", *args
    system "make"
    system "make install"
  end
end
