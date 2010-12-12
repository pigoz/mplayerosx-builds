class Time
  def to_ver(separator = nil)
    ["%04d" % year, "%02d" % month, "%02d" % mday].join(separator)
  end
end