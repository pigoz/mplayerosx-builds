require 'formula'

class Ffmpeg <Formula
  head 'git://git.videolan.org/ffmpeg.git', :using => :git
  homepage 'http://www.libav.org/'

  depends_on 'pkg-config' => :build
  depends_on 'yasm' => :build

  def install
    ENV.x11
    args = ["--prefix=#{prefix}",
            "--cc=clang",
            "--disable-debug",
            "--enable-shared",
            "--enable-gpl",
            "--enable-version3",
            "--enable-nonfree",
            "--enable-libfreetype",
            "--enable-postproc"]

    args << "--arch=x86_64" if snow_leopard_64?

    # For 32-bit compilation under gcc 4.2, see:
    # http://trac.macports.org/ticket/20938#comment:22
    if MacOS.leopard? or Hardware.is_32_bit?
      ENV.append_to_cflags "-mdynamic-no-pic"
    end

    system "./configure", *args

    if MacOS.prefer_64_bit?
      inreplace 'config.mak' do |s|
        shflags = s.get_make_var 'SHFLAGS'
        if shflags.gsub!(' -Wl,-read_only_relocs,suppress', '')
          s.change_make_var! 'SHFLAGS', shflags
        end
      end
    end

    system "make"
    system "make install"
  end
end
