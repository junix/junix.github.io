---
layout: post
title: diff and patch
categories:
- erlang
tags:
- erlang
---


## 使用diff制作补丁

```
$ diff -Nru dir1 dir2 > x.patch
```

## 打补丁


```
$ cd dir2
$ patch -R -p1 < x.patch
```


## 总结一下：

单个文件

```
diff –uN from-file to-file > to-file.patch
patch –p0 < to-file.patch
patch –RE –p0 < to-file.patch
```

多个文件

```
diff –uNr from-docu to-docu  > to-docu.patch
patch –p1 < to-docu.patch
patch –R –p1 < to-docu.patch
```
