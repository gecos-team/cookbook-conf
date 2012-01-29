actions :replace, :append, :insert_if_no_match, :insert_after_match, :remove

attribute :name, :kind_of => String, :name_attribute => true
attribute :owner, :kind_of => String
attribute :group, :kind_of => String
attribute :current_line, :kind_of => String
attribute :new_line, :kind_of => String
attribute :pattern, :kind_of => Regexp

def initialize(*args)
  super
  @action = :append unless @new_line.nil?
end
