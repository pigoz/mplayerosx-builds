require 'formula'

class Libav <Formula
  head 'git://git.libav.org/libav.git', :using => :git
  homepage 'http://www.libav.org/'

  depends_on 'pkg-config' => :build
  depends_on 'yasm' => :build

  def install
    args = ["--prefix=#{prefix}",
            "--cc=clang",
            "--enable-gpl",
            "--enable-nonfree",
            "--disable-indev=jack",
            "--disable-debug",
            "--enable-pthreads",
            "--enable-shared",
            "--enable-postproc",
            "--disable-devices",
            "--disable-avserver",
            "--disable-avprobe",
            "--disable-vaapi"]

    args << "--arch=x86_64" if snow_leopard_64?

    system "./configure", *args
    system "make"
    system "make install"
  end
end
