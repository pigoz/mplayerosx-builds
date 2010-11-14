class Pathname
  def make_executable
    chmod(stat.mode|00100) if exist? and not executable?
  end
  
  def cp_to(dest)
    FileUtils.cp(self, dest)
  rescue Errno::ENOENT
    FileUtils.mkdir_p dest.dirname
    retry
  end
  
  def liblist
    otool.select{|x| Pathname.new(x).basename != self.basename}
  end
  
  def otool
    %x[otool -L #{self}].each_line.grep(/\t(\/usr\/(local|X11|lib).*)/) do
      $1.gsub(/(\(.*\))/,'').strip
    end.select{|x| not x =~ /.^?(libobjc|libSystem|libgcc).?/}
  end
  
  def install_name_tool(dylib, prefix, libsdir = dirname)
    dylib = Pathname.new(dylib)
    prefix = Pathname.new(prefix)
    
    %x[install_name_tool -change #{dylib} #{prefix + dylib.basename} #{self}]
    %x[install_name_tool -id #{prefix + dylib.basename} \
      #{libsdir + dylib.basename}]
  end
  
  def absolute
    absolute? ? self : Pathname.pwd + self
  end
end