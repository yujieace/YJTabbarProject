<h1>自定义的不规则TabViewController</h1></br>

<h2>目标和原因</h2>
帮助用户定义属于自己的TabViewController。起因是自己的项目中需要用到一个异形的按钮，凸起在TabBar之上，</br>
比如闲鱼之类的APP的TabBar栏</br>
找了一圈找不到合适的框架，于是只能自己造轮子了。</br>

<h2>依赖</h2></br>
布局依赖Masonry</br>
动画依赖Pop</br>
使用Cocoapods管理依赖，所以，需要在podfile中添加：</br>
pod 'Masonry'</br>
pod 'pop'</br>
</br>

<h2>使用方式</h2></br>
<h3>初始化</h3></br>
YJTabBarController *tab=[[YJTabBarController alloc] init];</br>
也可以继承YJTabBarController并实现YJTabBarDelegate（optional）的方式来自定义</br>
<h3>需要设置的部分</3></br>
参照demo，必须设置的内容是viewControllers,normalImages或者defaultIcon</br>
标题是viewcontroll的title属性</br>
<h3>值得一提的部分</h3>
该Controller的生命周期和UIViewcontroller一直，所以可以使用viewDidLoad或者viewDidAppear等方法。</br>
千万记得要调用super方法，以让父类的布局等内容生效。</br>
