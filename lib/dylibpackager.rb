class DylibPackager
  
  def initialize(source)
    @source = Pathname.new(source)
  end
  
  def stage_to(dest_dir)
    dest_dir = Pathname.new(dest_dir).absolute
    dest_file = dest_dir + @source.basename
    
    @source.cp_to(dest_file)
    dest_file.make_executable
    
    cp_libraries(dest_file, dest_dir + 'lib')
    fix_libraries(dest_file, dest_dir + 'lib')
  end
  
  private
  def cp_libraries(file, to)
    file.liblist.each do |dylib|
      dylib.cp_to(to + dylib.basename)
      cp_libraries(to + dylib.basename, to)
    end
  end
  
  def fix_libraries(file, to)
    file.liblist.each do |dylib|
      file.install_name_tool(dylib, '@executable_path/lib', to)
      fix_libraries(to + dylib.basename, to)
    end
  end
end