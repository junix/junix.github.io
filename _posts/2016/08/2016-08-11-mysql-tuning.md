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

----
`innodb_flush_log_at_trx_commit`确定日志文件何时write。默认值`1`。意思是`每一次事务提交或事务外的指令都需要把日志写入（flush）硬盘`。这是很费时的。特别是使用电池供电缓存（Battery backed up cache）时。设成`2`对于很多运用，特别是从MyISAM表转过来的是可以的，它的意思是`不写入硬盘而是写入系统缓存`。日志仍然会每秒flush到硬盘，所以你一般不会丢失超过1-2秒的更新。设成`0`会更快一点，但安全方面比较差，即使MySQL挂了也可能会丢失事务的数据。而值2只会在整个操作系统挂了时才可能丢数据。

首先需要大致了解一下mysql日志操作步骤：

```
log_buff ---mysql写 (write)---> log_file ---OS刷新 (flush)---> disk
```

`innodb_flush_log_at_trx_commit` 参数解释：

`0`（延迟写）： 

```
log_buff  --1s--> log_file  ——> disk
```

`1`（实时写，实时刷）： 

```
log_buff  ——>  log_file  ——> disk
```

`2`（实时写，延迟刷）：

```
log_buff  ——> log_file --1s--> disk
```