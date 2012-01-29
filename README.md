Description
===========

LWRP to manage configuration files.

Right now the LWRP manages plain files but INI files are also planned to be managed.
The actions that can be done by this LWRP over plain files are:

* `:append` - Append a line at the end of the file
* `:remove` - Remove a specific line whith match with a passed pattern
* `:replace` - Replace a specific line with a new line
* `:insert_after_match` - Search for a pattern and insert a line after if it's found
* `:insert_if_not_match` - Search for a pattern and append a line if the pattern isn't found

You can add the recipe `conf` to a node `run_list`, so all the recipes from
that runlist can use the resources and providers.


Requirements
============

In order to use this LWRP from your cookbook or recipe you need to add
this cookbook as a dependency at the `metadata.rb` file.
But as long as `chef-client` doesn't manage the dependencies, you'll need
to add the cookbook also to the node's `run_list`.

After doing that you can do things like:

    conf_plain_file '/etc/hosts' do
      pattern  /test\.mydomain/
      new_line '127.0.0.1    test.mydomain.com'
      action   :insert_if_no_match
    end

Which will insert the `new_line` if the file doesn't contain the _pattern_
`/test.mydomain/`.

Usage
=====

To see how this works and how could be used from another cookbook, let's see
some examples.

Let's say we have a file named `/tmp/file.txt` which content is:

    0 - Line zero
    1 - First line
    2 - Second line
    3 - Third line
    4 - Last line


To replace one line with another one, we can do from our recipe:

    conf_plain_file '/tmp/file.txt' do
      current_line '2 - Second line'
      new_line     '2 - The new Second line'
      action :replace
    end

The result content will be:

    0 - Line zero
    1 - First line
    2 - The new Second line
    3 - Third line
    4 - Last line


To append one line we can do this:

    conf_plain_file '/tmp/file.txt' do
      new_line     '5 - New Last Line'
      action :append
    end

The result content will be:

    0 - Line zero
    1 - First line
    2 - Second line
    3 - Third line
    4 - Last line
    5 - New Last Line


To remove one specific line:

    conf_plain_file '/tmp/file.txt' do
      pattern /Third/
      action :remove
    end

The result content will be:

    0 - Line zero
    1 - First line
    2 - Second line
    4 - Last line


To append a line with some text if the text doesn't is yet at the file:

    conf_plain_file '/tmp/file.txt' do
      pattern   /6 -/
      new_line  '6 - A new line six'
      action :insert_if_no_match
    end

The result content will be:

    0 - Line zero
    1 - First line
    2 - Second line
    3 - Third line
    4 - Last line
    6 - A new line six


To insert a line in the file after another line but not at the end:

    conf_plain_file '/vagrant/insert_after_match.txt' do
      pattern   /First/
      new_line  '  1.5 - Almost second line'
      action :insert_after_match
    end

The result content will be:

    0 - Line zero
    1 - First line
      1.5 - Almost second line
    2 - Second line
    3 - Third line
    4 - Last line


License and Author
==================

Author:: Juanje Ojeda <juanje.ojeda@gmail.com>

Copyright:: 2011 Junta de Andalucía
Copyright:: 2012 Juanje Ojeda <juanje.ojeda@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

