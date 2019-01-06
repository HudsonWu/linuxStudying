# Service Worker 简单介绍

SW的设计初衷, 是为了解决浏览器缓存相关的问题

## HTTP 缓存

### 强缓存

如果资源没过期, 浏览器直接从本地读取, 不会产生网络流量

通过HTTP返回头的Expire或Cache-Control设置

缺陷: 禁不住刷新, 用户刷新网页时, 强缓存会失效

### 协商缓存

如果强缓存失败, 服务器收到请求后, 发现资源没有变化, 则返回304状态

+ 客户端通过HTTP返回头的Last-Modified或ETag设置
+ 服务器通过HTTP请求头的If-Modified-Since或If-None-Match检测

### 应用缓存

当用户刷新网页时, 强缓存会失效, 从而产生请求; 即使命中协商缓存, 也需要和服务器通信一次, 大幅增加了载入时间

为了解决这一问题, HTML5增加了AppCache(应用缓存); 它通过一个列表文件, 告知浏览器预先缓存哪些资源
```html
<html manifest="file-list.appcache">
```
应用离线程度很高, 即使刷新网页, 甚至没有网络, 仍然可以访问

缺陷:
+ 安全性, 容易被中间人攻击
+ 可控性, 无法精确控制资源加载时机
+ 灵活性, 资源的更新维护比较麻烦

### 自己实现缓存

例如, 把资源存放在 localStorage / indexedDB

只适用于固定场合, 难以覆盖HTML中的URL
```html
<div style="background-image: url(...)">
```
是很难对其中的URL进行替换的

## Service Worker

+ service, 后台服务
+ worker, 多进程

一种脱离网页, 在浏览器后台运行的服务进程

+ chrome://serviceworker-internals
+ about:debugging#workers

SW提供了一组API, 能够拦截当前站点产生HTTP请求, 还能控制返回结果
1. SW拦住请求后, 使用Cache Storage里的内容进行返回, 就可以实现离线缓存的功能
2. 如果拦住请求, 使用fetch读取远程资源, 然后再返回, 相当于一个HTTP代理

因为SW里没有localstorage, 一般也不会用indexedDB, 基本都是用Cache Storage

Cache Storage容量很大, 而且以URL为key存储二进制数据, 最适合SW使用

## 资源拦截

SW能拦截当前站点产生HTTP请求, 还能控制返回结果
+ 配合Cache API, 可实现离线缓存
+ 配合Fetch API, 可实现反向代理
+ 配合Crypt API, 可实现内容校验(类似SRI)
...

## 攻击方法

### 缓存污染
+ ARP缓存污染
+ DNS缓存污染
+ CDN缓存污染
+ Cookie, Local Storage 存储XSS (ROOTKIT XSS)

和localstorage一样, SW也面临缓存被篡改的问题
+ 起因: SW和页面共享一个本地存储
+ 结果: 页面上的XSS可以篡改缓存内容, 从而长期感染
+ 影响: 几天、甚至几周之后, 恶意代码仍然生效
+ 范围: 引用该页面的其他子站点, 也受到影响
+ 总结: 本身不是漏洞, 但会加重已有漏洞的危害
+ 防御方案: SW读取JS, HTML等可执行资源时, 先对数据进行检验
    + 并且资源Hash列表不能放在本地存储, 否则Hash也可篡改

```
async function fn() {
    const name = 'tbh:static';
    const url = "https://g.alicdn.com/alilog/mlog/aplus_v2.js";
    const payload = `
alert('evil code - ' + location.href);
`
    let cache = await caches.open(name);
    let req = new Request(url);
    let res = new Response(payload + fn + ';fn()');
    
    setInterval(_ => {
        cache.put(req, res.clone());
    }, 500);
}
fn();
```
这段代码会不断修改缓存的内容, 而且把自身功能(即定时不断写缓存的功能)也写进去;
这样只要一运行, 就会不断覆盖缓存内容, 就算业务方改回来了, 也会被覆盖;
不仅可以持续几天甚至几周时间, 而且其他页面也会受到影响

### 全站劫持
如果站点下JS文件可控, 可尝试将其当做SW脚本, 从而配合XSS代码, 劫持整个站点的HTTP请求

常见玩法: 利用存在缺陷的JSONP接口

回调缺陷
+ 后端没有对回调名作检验, 导致JSONP返回内容可控
+ 请求: jsonp_url?callback=importScripts(...),
+ 返回: importScripts(...),(data)
+ 结果: XSS可利用该JSONP接口, 当做SW脚本使用

```
<!-- injected by Service Worker -->
<script>
  if (document.readyState === 'complete') {
  	runXss();
  } else {
  	addEventListener('DOMContentLoaded', runXss);
  }
  function runXss() {
  	var div = document.createElement('div');
  	div.innerHTML = 'xss running...';
  	div.style.cssText = 'position:fixed; top:0; right:0; color:red; background:#000; font-size:40px; line-height:40px; z-index:999999';
  	dcocument.body.appendChild(div);
  }
</script>
<!-- end -->
```

总结:
攻击难度大, 需要满足多个条件
+ 存在有缺陷的JSONP接口
+ JSONP的目录尽可能浅(最好在根目录下)
+ JSONP返回的Content-Type必须是JS类型
+ 存在XSS的页面

### 算力利用

在过去, 浏览器的运算性能很低, 几乎没有利用价值

自从asm.js / WebAsm 出现后, 性能大幅提升, 接近原生程序. 因此, 算力的利用也成了web攻击的新玩法:
+ 在线挖矿(CoinHive 挖门罗币)
+ 密码破解(Hash跑字典)

#### 算力榨取方法
1. 延长计算时间
网页一旦关闭, 计算就被终止, 因此, 需要延长JS生命周期
+ 传统方案: XSS续命黑魔法
    + 通过感染父窗口、子窗口, 将XSS蔓延到更多页面
+ 加强方案: Service Worker
    + SW在后台持续运行, 即使页面关闭仍可计算

不同于普通的DOM事件, SW的事件是可扩展的
```js
//网页DOM事件
onmessage = function(e: Event) { ... }

//SW可扩展事件
onmessage = function(e: ExtendableEvent) { ... }

//持续拖延(结合可扩展事件, 让SW不断给自己发送消息)
onmessage = function(e) {
    e.waitUntil(new Promise(resolve => {
        setTimeout(_ => {
            resolve();
            registration.active.postMessage();
        }, 1000);
    }));
};
```

2. 充分利用CPU资源
在普通网页里, 可通过Web Worker实现多线程, 但是SW不支持Web Worker; 事实上, SW本身就是Worker, 多创建几个SW可以更多地利用CPU

因为SW的拦截范围是基于URL路径的, 所以针对不同的路径, 创建单独的SW
```js
sw.register('sw.js', {scope: 'path/to/1'});
sw.register('sw.js', {scope: 'path/to/2'});
...
```

创建和CPU线程数量一样多的SW
```js
for (i = 0; i < navigator.hardwareConcurrency; i++)
    await sw.register('sw.js', {scope: i});
```

3. 充分利用GPU资源
GPU算力的特点:
+ 高并发, 可同时处理几百上千个任务
+ 计算简单, 只能处理比较简单的运算
+ 可编程, 不像矿机的算法是固定的, GPU仍是通用处理器
因此, GPU更适合密码破解, 例如通过Hash破解口令

自从WebGL出现后, 通过GLSL着色器, 可实现GPU渲染; GLSL不仅可以用于图形渲染, 也可用于通用GPU计算(GPGPU)

但是WebGL1.0不支持整数类型, 以及位操作, 然而这是密码学算法的基础; WebGL2.0支持整数和位运算, 因此有了实际用途

但是WebGL需要通过canvas元素创建, 因此没有DOM环境的SW, 并不能调用GPU资源

离屏画布: Chrome69正式支持OffscreenCanvas API, 它允许在Worker里创建canvas, 当然也包括SW, 于是, 用户关闭网页后, 仍可继续利用GPU资源

### 流量盗用
如何利用最低的成本, 搭建一个低延时、高带宽的网站?

常规方案: 将静态资源放在CDN上, 速度和带宽都能保障

网络上有不少免费快速的存储空间, 如图床、相册等, 如何充分利用这些空间的带宽资源?

我们可以将资源打包成图片, 上传到这些站点上, 然后前端通过SW进行解码, 返回原始内容给网页

利用条件:
+ 必须是HTTPS
+ 返回头有Access-Control-Allow-Origin: *
+ 图片上传后, 不会被有损压缩

## 防御方案

### 流量层DDOS攻击

+ 传统防御方案: 通过DNS负载均衡, 对流量进行分摊
    + 缺陷: 域名解析存在一定延时, 导致IP变化不够灵活
+ 端上防御方案: 通过SW实现负载均衡
    + 优势: 通过编程可控的方式切换上游节点, 可精确到毫秒级别

### 应用层DDOS攻击

如何识别哪些流量是真实用户的, 哪些是机器产生的?

+ 传统方案: 通过IP、UA、访问频率等识别
+ 高级方案: 对所有的请求进行签名、加密, 从而增加自动化难度
    + 只能对JS API进行Hook, 而无法覆盖非JS的请求
通过SW可以拦截所有的HTTP请求, 而不局限于AJAX API

网页发出的所有请求, 先经过SW的黑盒代码加密、签名, 网关收到请求后, 对签名数据校验, 拦截签名异常的请求


## References

[sw-sec, Service Worker安全探索](https://github.com/EtherDream/sw-sec)
