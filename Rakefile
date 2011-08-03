$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'pathname'
require 'tty'
require 'extensions/pathname'
require 'extensions/time'
require 'extensions/hash'
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
  sh %{brew install #{(Pathname.pwd / 'formulae' / 'mplayer2.rb').realpath}}
end

task :uninstall do
  sh %{brew uninstall libav mplayer2}
end

task :rebuild => [:uninstall, :build] do ; end

namespace :sparkle do
  task :clear do
    Pathname.new('sparkle').rmtree
  end
  
  task :init do
    if Pathname.new('sparkle').exist? then
      onoe "Sparkle directory alredy exists. Run rake sparkle:clear"
      exit!
    end
    Pathname.new('sparkle').mkdir
    sh "mkdir sparkle"
    sh "git clone -b gh-pages \
        git@github.com:pigoz/mplayerosx-builds.git sparkle"
  end
end

namespace :pkg do
  # Rake task to create a personal/testing version of the bundle
  task :mposxt do
    require 'mposxbinpackager'
    pkgr = MPOSXBinPgkr.new('share/mplayer-git.mpBinaries',
                            'mplayer-git-local.mpBinaries')
    pkgr.stage_to('deploy')
    pkgr.make_plist({
      :name => "mplayer.git (local)",
      :identifier => "com.google.code.mplayerosx-builds.git.local"
    })
    pkgr.bundle_mplayer
  end

  # Rake task to create the distributable self updating bundle
  task :mposxd do
    require 'erb'
    require 'mposxbinpackager'
    pkgr = MPOSXBinPgkr.new('share/mplayer-git.mpBinaries')
    pkgr.stage_to('deploy')
    pkgr.add_key('~/dsa_pub.pem')
    pkgr.make_plist({
        :appcast => "http://pigoz.github.com/mplayerosx-builds" + 
                      "/mplayer-git.mpBinaries.appcast.xml",
        :dsa_key => "dsa_pub.pem" })
    pkgr.bundle_mplayer

    zipfile, time = pkgr.zip
    dsa = `openssl dgst -sha1 -binary < deploy/#{zipfile} |\
     openssl dgst -dss1 -sign ~/dsa_priv.pem | openssl enc -base64`.strip

    appcast = ERB.new(IO.read('share/mplayer-git.mpBinaries.appcast.xml.erb'))
    locals = {:zipfile => zipfile, :time => time, :dsa => dsa,
              :size => File.size('deploy/'+zipfile)}
    File.open('sparkle/mplayer-git.mpBinaries.appcast.xml', 'w+') do |f|
      f.puts appcast.result(locals.to_binding)
    end

    git_commit = `cd ~/Library/Caches/Homebrew/mplayer2--git && \
      git log -n1 | grep ^commit. | sed -e 's/^commit.//g'`.strip
    rnotes = ERB.new(IO.read('share/mplayer-git.mpBinaries.rnotes.html.erb'))
    locals = {:time => time, :commit => git_commit}
    File.open("sparkle/mplayer-git.mpBinaries.rnotes/#{time.to_ver("-")}.html",
              'w+') do |f|
      f.puts rnotes.result(locals.to_binding)
    end
  end

  task :mpb, :version do |t, args|
    require 'mppackager'
    pkgr = MPPgkr.new('share/mplayer2.app')
    pkgr.stage_to('deploy')
    args.with_defaults(:version => Time.now.to_ver('-'))
    pkgr.make_plist(args)
    pkgr.bundle_mplayer
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
