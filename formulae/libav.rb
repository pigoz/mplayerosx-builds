require 'formula'

class Libav <Formula
  head 'git://git.libav.org/libav.git',
    :using => :git,
    :ref => "01cb62aba2503b4173f101154f9f840f04f9c7f8"
  homepage 'http://www.libav.org/'

  depends_on 'pkg-config' => :build
  depends_on 'yasm' => :build

  def install
    args = ["--prefix=#{prefix}",
            "--cc=clang",
            "--enable-gpl",
            "--disable-debug",
            "--enable-pthreads",
            "--enable-shared",
            "--enable-postproc",
            "--disable-devices",
            "--enable-vda",
            "--disable-vaapi"]

    args << "--arch=x86_64" if snow_leopard_64?

    system "./configure", *args
    system "make"
    system "make install"
  end
end
