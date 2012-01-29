
def write_new_file(name, new_line, owner, group)
  file name do
    content "#{new_line}\n"
    owner owner
    group group
    action :create
  end
end

action :replace do
  if ::File.exists? new_resource.name
    current_content = Chef::Util::FileEdit.new new_resource.name
    current_content.search_file_replace(new_resource.current_line, new_resource.new_line)
    current_content.write_file
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug("replace action couldn't be performed. #{new_resource.name} does not exist")
  end
end

action :append do
  if ::File.exists? new_resource.name
      open(new_resource.name, 'a') { |f| f.puts new_resource.new_line }
  else
    write_new_file(new_resource.name,
                   new_resource.new_line,
                   new_resource.owner,
                   new_resource.group)
  end
  new_resource.updated_by_last_action(true)
end

action :insert_if_no_match do
  if ::File.exists? new_resource.name
    new_file = Chef::Util::FileEdit.new new_resource.name
    new_file.insert_line_if_no_match(new_resource.pattern,
                                     new_resource.new_line)
    new_file.write_file
  else
    write_new_file(new_resource.name,
                   new_resource.new_line,
                   new_resource.owner,
                   new_resource.group)
  end
  new_resource.updated_by_last_action(true)
end

action :insert_after_match do
  if ::File.exists? new_resource.name
    new_file = Chef::Util::FileEdit.new new_resource.name
    new_file.insert_line_after_match(new_resource.pattern,
                                     new_resource.new_line)
    new_file.write_file
  else
    write_new_file(new_resource.name,
                   new_resource.new_line,
                   new_resource.owner,
                   new_resource.group)
  end
  new_resource.updated_by_last_action(true)
end

action :remove do
  if ::File.exists? new_resource.name
    new_file = Chef::Util::FileEdit.new new_resource.name
    new_file.search_file_delete_line(new_resource.pattern)
    new_file.write_file
    new_resource.updated_by_last_action(true)
  end
end

