class Hash
  def to_binding(object = Object.new)
    object.instance_eval("def binding_for(#{keys.join(",")}) binding end")
    object.binding_for(*values)
  end
end