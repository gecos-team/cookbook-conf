action :replace do
  file new_resource.name do
    replace(new_resource.before, new_resource.after) if include?(new_resource.before)
    owner new_resource.owner
    group new_resource.group
    mode "0644"
    action :touch
  end
end
