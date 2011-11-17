action :replace do
  file new_resource.name do
    replace(new_resource.before, new_resource.after) if include?(new_resource.before)
  end
end
