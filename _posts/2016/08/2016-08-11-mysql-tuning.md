---
layout: post
title: MySQL配置
categories:
- MySQL
tags:
- MySQL
---

### MySQL常用配置

#### `innodb_buffer_pool_size`

this is the #1 setting to look at for any installation using InnoDB. The buffer pool is where data and indexes are cached: having it as large as possible will ensure you use memory and not disks for most read operations. Typical values are:

| 建议配置大小 | 机器物理内存 |
| :--          | :--          |
| 5-6GB        | 8GB          |
| 20-25GB      | 32GB         |
| 100-120GB    | 128GB        |

