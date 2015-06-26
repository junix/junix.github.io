---
layout: post
title: Maxwell 调试常用命令
categories:
- erlang
tags:
- erlang
---

### 查看表

### console版本

```
mnesia:transaction(fun()->qlc:e(qlc:q([E||E<-mnesia:table(user_agent)]))end).
```

### rpc版本

```
rpc:call(M,mnesia,transaction,[fun()->qlc:e(qlc:q([E||E<-mnesia:table(user_agent)]))end]).
```


