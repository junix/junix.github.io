---
layout: post
title: Add node to mnesia
categories:
- erlang
tags:
- erlang
---


Start your new node (b@node) erl -sname b -mnesia dir '"/path/to/storage"' -s mnesia. This starts a new ram_copes node called b@node.

On your original node (a@node), at the erlang prompt execute mnesia:change_config(extra_db_nodes, ['b@node']). This will cause the original node to connect b to the mnesia cluster. At this point, b@node has joined the cluster but only has a copy of the schema.

To make new the node b@node capable of storing disc copies, we need to change the schema table type on b@node from ram_copies to disc_copies. Run mnesia:change_table_copy_type(schema, 'b@node', disc_copies). on any node.

b@node only has a copy of the schema at this point. To copy all the tables from a@node to b@node and maintain table types, you can run:

```
[{Tb, mnesia:add_table_copy(Tb, node(), Type)}
|| {Tb, [{'a@node', Type}]} <- [{T, mnesia:table_info(T, where_to_commit)}
|| T <- mnesia:system_info(tables)]].
```


This command may take a while to execute as it will copy the contents of each table over the network.

b@node is now an exact replica of a@node. You could modify that statement - replace the Type variable with disc_only_copies in the call to mnesia:add_table_copy/3 in order to copy the tables but ensure they're on disc only.

The mnesia documentation explains how to use the functions I've shown here.

