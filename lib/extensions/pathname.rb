class Pathname
  alias_method :/, :+
  
  def cp_to(dest)
    FileUtils.rm_r(dest, :force => true)
    FileUtils.cp_r(self, dest)
  rescue Errno::ENOENT
    FileUtils.mkdir_p(dest.dirname)
    retry
  end
  
  def liblist
    usrlibs.select{|x| x.basename != self.basename}
  end
  
  def usrlibs
    otool.select do |x|
      not x =~ /.^?(libobjc|libSystem|libgcc).?/ || x =~ /^\/System.+/
    end.map {|x| Pathname.new(x)}
  end
  
  def otool
    %x[otool -L #{self}].each_line.grep(/\t(.*)/) do
      $1.gsub(/(\(.*?\))/,'').strip
    end
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