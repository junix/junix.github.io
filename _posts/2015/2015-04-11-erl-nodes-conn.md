---
layout: post
title: Erlang节点的连接
categories:
- erlang
tags:
- erlang
---
### *LONG NAME*和*SHORT NAME*的设置
举例来说，

```
erl -name li@Server1.com    
erl -name li@10.68.8.50
```
这是设置*LONG NAME*，用*-name*设置。

而如果使用:

```
erl -sname li@Server1
erl -sname li    
```
这是设置*SHORT NAME*，用*-sname*设置。

从格式上来说，*SHORT NAME*后面跟的域名不能是IP，也不能够带有```.```，比如不能是```Server1.com```，而只能是```Server1```。

从用法上来说：

1. 如果两个节点运行在一个机器上，就用*-sname*；
2. 如果两个节点运行在不同的机器上，且两个机器运行在不同的网段，那么必须用*-name*，erlang会通过DNS解析出名字中的域名，找到对应的机器；
3. 如果两个节点运行在不同的机器上，但两个机器在同一个子网中，那么可以和上面一样用*-name*方式，也可以用*-sname*，但是必须保证**sname的名字在/etc/hosts中**。比如,如果使用了```erl -name li@Server1```，则在```/etc/hosts```中需要添加```Server1 10.68.8.51```。总而言之，**如果需要用到DNS，那么必须使用LONG NAME，如果不需要用到DNS，可以使用sname，但需要设置/etc/hosts**。


了解了LONG NAME和SHORT NAME的区别，下面的部分就容易了。以书中的代码为例，

> 假设现在有两台机器A和B，静态IP分别为10.68.8.50和10.68.8.51，机器名分别为Server1.aaa.com和Server2.aaa.com，且在同一个子网中。

那么可以实验如下操作：


### 方案1（-sname与host设置）：
A：设置/etc/hosts，添加 

``` 
Server2 10.68.8.51
```
设置短名字，启动服务:

```
erl -sname gandalf@Server1 -setcookie abc
kvs:start().
```

B：设置/etc/hosts，添加 

```
Server1 10.68.8.50
```

设置短名字，启动服务:

```
erl -sname bilbo@Server2 -setcookie abc
>rpc:call(gandalf@Server1, kvs, store, [weather, fine]).
```

结果： 正确输出。

### 方案2（用IP设置name）
A：

```
erl -name gandalf@10.68.8.50 -setcookie abc
> kvs:start().
```

B：

```
erl -name bilbo@10.68.8.51 -setcookie abc
> rpc:call(’gandalf@10.68.8.50‘, kvs, store, [weather, fine]).
```

结果： 正确输出。
注意：在rpc:call中，gandalf@10.68.8.50必须加上单引号，否则识别不了正确的IP

### 方案3（用域名设置name）
A：

```
erl -name gandalf@Server1.aaa.com -setcookie abc
> kvs:start().
```

B：

```
erl -name bilbo@Server2.aaa.com -setcookie abc
> rpc:call(gandalf@Server1.aaa.com, kvs, store, [weather, fine]).
```

结果： 如果DNS能够解析Server1.aaa.com，那么结果正确。否则找不到对应的节点。
