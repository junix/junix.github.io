---
layout: post
title: brew 安装特殊版本
categories:
- mac
tags:
- mac
---

### brew 安装特殊版本

首先要查询brew仓库支持那些版本

```
$ brew search llvm
llvm
homebrew/versions/llvm-gcc28
homebrew/versions/llvm34	
homebrew/versions/llvm36
homebrew/versions/llvm33
homebrew/versions/llvm35
```

这里，我们要安装llvm 3.4,那么执行如下命令，就可以安装 LLVM 3.4

```
$ brew install omebrew/versions/llvm34
```
