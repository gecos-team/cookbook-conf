
action :replace do
  if ::File.exists? new_resource.name
    old_content = Chef::Util::FileEdit.new new_resource.name
    old_content.search_file_replace(new_resource.before, new_resource.after)
    old_content.write_file
  else
    Chef::Log.debug("replace action couldn't be performed. #{new_resource.name} does not exist")
  end
end

action :add do
  if ::File.exists? new_resource.name
    new_file = Chef::Util::FileEdit.new new_resource.name
    new_file.insert_line_if_no_match(new_resource.pattern, new_resource.new_line)
    new_file.write_file
  else
    file new_resource.name do
      content new_resource.new_line + "\n"
      owner new_resource.owner
      group new_resource.group
      action :create
    end
  end
end

action :remove do
  if ::File.exists? new_resource.name
    new_file = Chef::Util::FileEdit.new new_resource.name
    new_file.search_file_delete_line(new_resource.pattern)
    new_file.write_file
  end
end

