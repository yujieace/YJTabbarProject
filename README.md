<h1>自定义的不规则TabViewController</h1></br>

<h2>目标</h2>
帮助用户定义属于自己的TabViewController。起因是自己的项目中需要用到一个异形的按钮，凸起在TabBar之上，</br>
比如闲鱼之类的APP的TabBar栏</br>
<img>http://bcs.91.com/rbpiczy/soft/2014/6/26/c1483f8eb0e647869be2ca7e6e84756e/thumb_e50c743e52c6478cbb0b1a2aaa760d96_640x960_320x480.jpg</img>
找了一圈找不到合适的框架，于是只能自己造轮子了。</br>

<h2>依赖</h2></br>
布局依赖Masonry</br>
动画依赖Pop</br>
使用Cocoapods管理依赖，所以，需要在podfile中添加：</br>
pod 'Masonry'</br>
pod 'pop'</br>
</br>

<h2>使用方式</h2></br>
