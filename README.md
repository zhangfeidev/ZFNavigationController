#ZFNavigationController
##简介
很喜欢天猫和网易新闻的导航控制器的pop效果，于是封装了一个相同的pop效果。将自定义的navigationBar作为了viewcontroller的属性。第一版封装得比较简单，后期再深度封装一下。当然我只是抛砖引玉，希望喜欢这个效果的朋友们拿去自己DIY吧！
##效果
![](http://ww2.sinaimg.cn/large/cfaa8811jw1ez0fikjqltg208s0fodl2.gif)
##使用方法
>首先将ZFNavigationController文件夹拖入工程中，在AppDelegate中设置你的导航控制器。

``` Objective-C
ViewController *viewVC = [[ViewController alloc] init];
ZFNavigationController  *nav = [[UINavigationController alloc] initWithRootViewController:viewVC];
self.window.rootViewController = nav;
```
- 开启全屏返回手势

``` Objective-C
nav.fullScreenPopGesture = YES;
```
- 设置viewcontroller的title

``` Objective-C
self.title = @"首页";
```
- viewcontroller隐藏navigationBar

``` Objective-C
self.navigationBarHidden = YES;
```

>如果是storyboard，使用User Defined Runtime Attributes

![](http://ww1.sinaimg.cn/large/cfaa8811jw1ez0h12hrthj20pp0nyq5n.jpg)

![](http://ww2.sinaimg.cn/large/cfaa8811jw1ez0h165pfoj20po0nzdij.jpg)

博客地址：[小飞的技术博客](http://zhangfei.tk/2015/12/05/Runtime%E5%AE%9E%E6%88%98%E4%B9%8B%E5%AF%BC%E8%88%AA%E6%8E%A7%E5%88%B6%E5%99%A8%E9%82%A3%E4%BA%9B%E4%BA%8B/#more),欢迎star！
##License
MIT

