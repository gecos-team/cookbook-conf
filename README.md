Description
===========

This cookbok install a policy of shares (network shared directories) to a specific user of a node.

The cookbook ships the policies and install a script into the node that will make the shares availables by the user.

Requirements
============

Attributes
==========

* `node['user']` - Name of the user to apply the policies
* `node['shares']` - List of shares and mount points

Usage
=====

