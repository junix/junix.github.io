---
layout: post
title: 怎么用brew 安装软件的特定版本
categories:
- mac
tags:
- mac
---

### brew 安装版本特定的软件

例如，我们需要安装LLVM 3.4。但是，使用brew默认安装的是3.5。那么怎么安装LLVM 3.4呢？

首先要查询brew仓库支持该软件的那些版本

```
$ brew search llvm
llvm
homebrew/versions/llvm-gcc28
homebrew/versions/llvm34	
homebrew/versions/llvm36
homebrew/versions/llvm33
homebrew/versions/llvm35
```

这里，我们要安装LLVM 3.4,那么执行如下命令，就可以安装 LLVM 3.4。

```
$ brew install homebrew/versions/llvm34
```
