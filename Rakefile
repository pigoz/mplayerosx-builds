$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'pathname'
require 'tty'
require 'extensions/pathname'
require 'extensions/time'
begin
  require 'rspec/core/rake_task'
rescue LoadError
  puts 'To use rspec for testing you must install rspec gem:'
  puts 'gem install rspec'
  exit
end

task :build do
  if %x[which brew].strip.empty? then
    onoe "Can't find homebrew installed on your system. Is brew in your path?"
    exit!
  end

  puts %x[brew install #{(Pathname.pwd + \
    'formulae' + 'mplayer.rb').realpath} 1>&2]
end

namespace :pkg do
  task :stage do
    begin
      require 'dylibpackager'
    rescue LoadError
      onoe "Can't load mplayerosx-builds libraries: check your $LOAD_PATH"
      exit!
    end

    lt = DylibPackager.new(Pathname.new(%x[which mplayer].strip))
    lt.stage_to('work')
  end
  
  task :mposx do
    require 'mposxbinpackager'
    
    pkgr = MPOSXBinPgkr.new('share/mplayer-git.mpBinaries')
    pkgr.stage_to('deploy')
    pkgr.make_plist({:name => "mplayer.git (private)"})
    pkgr.bundle_mplayer
  end

  task :mposxrelease do
    require 'mposxbinpackager'
    
    pkgr = MPOSXBinPgkr.new('share/mplayer-git.mpBinaries')
    pkgr.stage_to('deploy')
    pkgr.add_key('~/dsa_pub.pem')
    pkgr.make_plist({
        :SUFeedURL => "http://pigoz.github.com/mplayerosx-builds/appcast.xml",
        :SUPublicDSAKeyFile => "dsa_pub.pem" })
    pkgr.bundle_mplayer
  end
  
  task :mpclibin do
    ohai "::todo:: :)"
  end
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:specdoc) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ['--format documentation']
end
