require 'spec_helper'
require 'dylibpackager'

binary = "mplayer"
describe DylibPackager, "after staging #{binary}" do

  before :all do
    lt = DylibPackager.new(Pathname.new(%x[which #{binary}].strip))
    lt.stage_to 'test/work'
  end
  
  after :all do
    FileUtils.rm_rf 'test'
  end
  
  it "should have created the directories" do
    Pathname.new('test/work').should exist
    Pathname.new('test/work/lib').should exist
  end
  
  it "should have copied the binary" do
    Pathname.new("test/work/#{binary}").should exist
  end
  
  it "should have copied #{binary}'s dylibs (non system)" do  
    Pathname.new("test/work/#{binary}").usrlibs.each do |dylib|
      Pathname.new("test/work/lib/#{dylib.basename}").should exist
    end
  end
  
  it "should have copied #{binary}'s dylibs recursively (non system)" do
    Pathname.new("test/work/lib/*").usrlibs.each do |dylib|
      Pathname.new("test/work/lib/#{dylib.basename}").should exist
    end
  end
  
  it "should have copied #{binary}'s dylibs (non system)" do
    Pathname.new("test/work/#{binary}").usrlibs.each do |dylib|
      dylib.to_s.should =~ /^@executable_path\/lib\/#{dylib.basename}/
    end
  end
  
  it "should have copied #{binary}'s dylibs recursively (non system)" do
    Pathname.new("test/work/lib/*").usrlibs.each do |dylib|
      dylib.to_s.should == "@executable_path/lib/#{dylib.basename}"
    end
  end
end