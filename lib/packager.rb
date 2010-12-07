# A module of methods for the book-keeping of staging operations
class Packager
  attr_reader :source
  
  def initialize(source)
    @source = Pathname.new(source)
  end
  
  def stage_to(dest_dir, &block)
    dest_dir = Pathname.new(dest_dir).absolute
    dest_file = dest_dir + @source.basename
    
    @source.cp_to(dest_file)
    block.call(dest_dir, dest_file) if block_given?
    [dest_dir, dest_file]
  end
end