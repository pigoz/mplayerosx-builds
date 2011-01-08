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
  sh %{brew install #{(Pathname.pwd / 'formulae' / 'mplayer.rb').realpath}}
end

task :uninstall do
  sh %{brew uninstall ffmpeg mplayer}
end

task :rebuild => [:uninstall, :build] do ; end

namespace :sparkle do
  task :init do
    sh "mkdir sparkle"
    sh "cd sparkle && git clone -b gh-pages /
        git@github.com:pigoz/mplayerosx-builds.git"
  end
end

namespace :pkg do
  # Rake task to create a personal/testing version of the bundle
  task :mposxt do
    require 'mposxbinpackager'
    pkgr = MPOSXBinPgkr.new('share/mplayer-git.mpBinaries')
    pkgr.stage_to('deploy')
    pkgr.make_plist({
      :name => "mplayer.git (local)",
      :identifier => "com.google.code.mplayerosx-builds.git.local"
    })
    pkgr.bundle_mplayer
  end

  # Rake task to create the distributable self updating bundle
  task :mposxd do
    require 'mposxbinpackager'
    pkgr = MPOSXBinPgkr.new('share/mplayer-git.mpBinaries')
    pkgr.stage_to('deploy')
    pkgr.add_key('~/dsa_pub.pem')
    pkgr.make_plist({
        :SUFeedURL => "http://pigoz.github.com/mplayerosx-builds/appcast.xml",
        :SUPublicDSAKeyFile => "dsa_pub.pem" })
    pkgr.bundle_mplayer
    zipfile, time = pkgr.zip
    
    require 'erb'
    dsa = `openssl dgst -sha1 -binary < deploy/#{zipfile} |\
     openssl dgst -dss1 -sign ~/dsa_priv.pem | openssl enc -base64`.strip
    appcast = ERB.new(IO.read('share/mplayer-git.mpBinaries.appcast.xml.erb'))
    puts appcast.result(binding)
    
    
  end
end

# Unit tests tasks
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:specdoc) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ['--format documentation']
end
