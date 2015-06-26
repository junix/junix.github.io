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

### 创建Agent

#### console

```
A1  = {agent_t, "a2",'IPHONE',"5s",lifebook_misc:current() + 100000}.
lifebook:replace_agent(136,A2).
```

### 创建新的Session

```
lifebook:new_session(134,{session_t,"s1","a1","iPhone 5s",<<"in-005-bj:2013:2014">>,lifebook_misc:current() + 1000,[]}).
lifebook:update_session_attr(134,"s1","subscribed",<<1:8>>).
```
### 向某个用户发送一条消息

```
maxwell_backend_receiver:handle({sr_msg_t, 234, [134],[],<<"(-------)">>,1234}).
```

