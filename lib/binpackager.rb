require 'plist'

class MpBinPkgr < Stager
  
  def plist(svn_rev, time = Time.now)
    y, m, d = "%04d"%time.year, "%02d"%time.month, "%02d"%time.mday
    {
      :CFBundleName => "mplayer.git",
      :MPEBinaryDescription => "Bleeding edge version of the mplayer binary " <<
                               "compiled with ffmpeg-mt, newest libass " << 
                               "available and ordered chapters support. " <<
                               "x86_64 and Snow Leopard only.",
      :MPEBinaryMaintainer => "Stefano Pigozzi",
      :MPEBinaryHomepage => "http://github.com/pigoz/mplayerosx-builds",
      :MPEBinarySVNRevisionEquivalent => svn_rev.to_s,
      :CFBundleVersion => "#{y}#{m}#{d}",
      :CFBundleShortVersionString => "#{y}-#{m}-#{d}",
      :CFBundleIdentifier => "com.github.pigoz.mplayerosx-builds",
      :CFBundleExecutable => "mplayer",
      :CFBundleInfoDictionaryVersion => "6.0",
      :SUFeedURL => "http://pigoz.github.com/mplayerosx-builds/appcast.xml",
      :SUPublicDSAKeyFile => "dsa_pub.pem",
      :LSBackgroundOnly => 1
    }.to_plist
  end
  
end