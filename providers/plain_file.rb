action :replace do
  file new_resource.name do
    if ::File.exists? new_resource.name
      old_content = IO.read new_resource.name
      if old_content =~ /#{new_resource.before}/
        content old_content.gsub(new_resource.before, new_resource.after)
      end
      owner new_resource.owner
      group new_resource.group
    else
      Chef::Log.debug("replace action couldn't be performed. #{new_resource.name} does not exist")
    end
  end
end

action :add do
  file new_resource.name do
    if ::File.exists? new_resource.name
      old_content = IO.read new_resource.name
    else
      old_content = ""
    end
    old_content << new_resource.new_line + "\n"
    content old_content
    owner new_resource.owner
    group new_resource.group
  end
end

action :remove do
  file new_resource.name do
    if ::File.exists? new_resource.name
      old_content = IO.read new_resource.name
      new_content = ""
      old_content.each do |line|
        new_content << line unless line =~ /#{new_resource.pattern}/
      end
      content new_content
      owner new_resource.owner
      group new_resource.group
    end
  end
end

