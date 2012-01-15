module MPlayerBundler
  def mplayer
    "mplayer2"
  end

  def mplayer_dest_basename
    nil
  end

  def bundle_mplayer
    lt = DylibPackager.new(Pathname.new(%x[which #{mplayer}].strip), mplayer_dest_basename)
    lt.stage_to(self.binary_dir)
  end
end

# A class to deal with binary packaging lifecycle
class Packager
  include MPlayerBundler
  attr_reader :source

  def destination; @dest_file; end

  def initialize(source, dest_basename = nil)
    @source = Pathname.new(source)
    @dest_basename = dest_basename || @source.basename
  end

  def stage_to(dest_dir, &block)
    dest_dir = Pathname.new(dest_dir).absolute
    @dest_file = dest_dir + @dest_basename

    @source.cp_to(@dest_file)
    block.call(dest_dir, @dest_file) if block_given?
    [dest_dir, @dest_file]
  end

  def binary_dir
    contents_dir + 'MacOS'
  end

  def resources_dir
    contents_dir + 'Resources'
  end

  def contents_dir
    destination + 'Contents'
  end

  def make_plist(options)
    raise "Make sure you implement plist method" unless self.respond_to? :plist
    File.open(contents_dir + 'Info.plist' , 'w+') do |fd|
      fd.write(plist(options))
    end
  end

  def add_key(original)
    FileUtils.cp(Pathname.new(original).expand_path, resources_dir)
  end

  def zip(time=Time.now)
    sh %{cd "#{@dest_file.dirname}" && \
         zip -rq #{zip_filename(time)} #{@dest_file.basename}}
    [zip_filename(time), time]
  end

  private
  def zip_filename(time=Time.now)
    "mplayer2-#{time.to_ver("-")}.zip"
  end
end
