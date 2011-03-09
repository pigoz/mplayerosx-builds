begin
  require 'plist'
rescue LoadError
  puts 'To use the mplayer bundler you must install the plist gem:'
  puts 'gem install plist'
  exit
end
require 'packager'
require 'dylibpackager'

class MPPgkr < Packager
  
  def bundle_mplayer
    lt = DylibPackager.new(Pathname.new(%x[which mplayer].strip))
    lt.stage_to(self.binary_dir)
  end
  
  def plist(options = {})
    options[:name] ||= "mplayer2"
    options[:identifier] ||= "org.mplayer2.mplayer2.standalone"
    options[:version] ||= "2.0"
    r = {
      :CFBundleIdentifier => options[:identifier],
      :CFBundleName => options[:name],
      :CFBundlePackageType => "APPL",
      :CFBundleShortVersionString => options[:version],
      :CFBundleExecutable => "mplayer",
      :CFBundleIconFile => "icon",
      :CFBundleInfoDictionaryVersion => "6.0",
      :CFBundleDevelopmentRegion => "English",
      :CFBundleDocumentTypes => [
          {:CFBundleTypeExtensions => audio_extensions,
           :CFBundleTypeIconFile => "audio.icns",
           :CFBundleTypeName => "Audio file",
           :CFBundleTypeRole => "Viewer",
           :LSTypeIsPackage => false,
           :NSPersistentStoreTypeKey => "XML"
           },
           {:CFBundleTypeExtensions => video_extensions,
            :CFBundleTypeIconFile => "movie.icns",
            :CFBundleTypeName => "Movie file",
            :CFBundleTypeRole => "Viewer",
            :LSTypeIsPackage => false,
            :NSPersistentStoreTypeKey => "XML"
            },
            {:CFBundleTypeExtensions => subtitles_extensions,
             :CFBundleTypeIconFile => "subtitles.icns",
             :CFBundleTypeName => "Subtitles file",
             :CFBundleTypeRole => "Viewer",
             :LSTypeIsPackage => false,
             :NSPersistentStoreTypeKey => "XML"
             }
        ],
        :CFBundleURLTypes => [
          {:CFBundleTypeRole => "Viewer",
           :CFBundleURLName => "Real Time (Streaming) Protocol",
           :CFBundleURLSchemes => ["rtp", "rtsp"]},
          {:CFBundleTypeRole => "Viewer",
           :CFBundleURLName => "File over HTTP/FTP/UDP",
           :CFBundleURLSchemes => ["icyx", "udp", "ftp", "http_proxy", "http"]},
          {:CFBundleTypeRole => "Viewer",
           :CFBundleURLName => "Microsoft Media Services",
           :CFBundleURLSchemes => ["mms"]},
          {:CFBundleTypeRole => "Viewer",
           :CFBundleURLName => "Cuesheet",
           :CFBundleURLSchemes => ["cue"]},
          {:CFBundleTypeRole => "Viewer",
           :CFBundleURLName => "CD/DVD Media",
           :CFBundleURLSchemes => ["dvdnav", "dvd", "vcd"]}
        ]
    }
    r.to_plist
  end
  
  private
  def to_exts(ary)
    (ary + ary.map(&:upcase)).sort
  end
  
  def audio_extensions
    extensions = ['aac', 'ac3', 'aiff', 'm4a', 'mka', 'mp3', 'ogg', 'pcm',
                  'vaw', 'wav', 'waw', 'wma']
    to_exts(extensions)
  end
  
  def video_extensions
    extensions = ['3gp', '3iv', 'asf', 'avi', 'cpk', 'dat', 'divx', 'dv',
                  'flac', 'fli', 'flv', 'h264', 'i263', 'm2ts', 'm4v', 'mkv',
                  'mov', 'mp2', 'mp4', 'mpeg', 'mpg', 'mpg2', 'mpg4', 'nut',
                  'nuv', 'nsv', 'ogg', 'ogm', 'qt', 'rm', 'rmvb', 'vcd', 'vob',
                  'vfw', 'wmv', '*']
    to_exts(extensions)
  end
  
  def subtitles_extensions
    extensions = ['aqt', 'ass', 'jss', 'rt', 'smi', 'ssa', 
                  'srt', 'sub', 'txt', 'utf']
    to_exts(extensions)
  end
end