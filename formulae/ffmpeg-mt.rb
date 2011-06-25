require 'formula'

class FfmpegMt <Formula
  head 'git://git.videolan.org/ffmpeg.git', :using => :git
  homepage 'http://www.ffmpeg.org/'

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
            "--disable-ffplay",
            "--disable-ffserver",
            "--disable-ffprobe",
            "--disable-vaapi"]

    args << "--arch=x86_64" if snow_leopard_64?

    system "./configure", *args
    system "make"
    system "make install"
  end
end
