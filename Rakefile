$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'pathname'
require 'tty'
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

task :stage do
  begin
    require 'extensions/pathname'
    require 'dylibpackager'
  rescue LoadError
    onoe "Can't load mplayerosx-builds libraries, please check your $LOAD_PATH"
    exit!
  end

  lt = DylibPackager.new(Pathname.new(%x[which mplayer].strip))
  lt.stage_to('work')
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:specdoc) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ['--format documentation']
end
