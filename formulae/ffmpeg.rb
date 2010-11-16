require 'formula'

class Ffmpeg <Formula
  head 'git://repo.or.cz/FFMpeg-mirror/mplayer-patches.git', :using => :git, :branch => :mt
  homepage 'http://gitorious.org/ffmpeg/ffmpeg-mt'

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
              "--cpu=host",
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
    
    if MACOS_VERSION >= 10.6 and Hardware.is_32_bit?
      ENV.append_to_cflags "-mdynamic-no-pic"
    end

    system "./configure", *args

    if snow_leopard_64?
      inreplace 'config.mak' do |s|
        shflags = s.get_make_var 'SHFLAGS'
        s.change_make_var! 'SHFLAGS', shflags.gsub!(' -Wl,-read_only_relocs,suppress', '')
      end
    end
    
    system "make"
    system "make install"
  end
end
