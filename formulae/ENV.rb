module LocalGCCENVExtension
  def local_gcc
    self['CC']  = `which gcc-4.2`.strip
    self['CXX'] = `which g++-4.2`.strip
    replace_in_cflags '-O4', '-O3'
    set_cpu_cflags 'core2 -msse4', :penryn => 'core2 -msse4.1', :core2 => 'core2', :core => 'prescott'
    @compiler = :gcc
  end
end

ENV.extend LocalGCCENVExtension