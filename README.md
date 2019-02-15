![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg)
![](https://img.shields.io/vscode-marketplace/d/repo.svg)
![](https://img.shields.io/cocoapods/l/packageName.svg)

# GHCarouselMapDemo
`超简单无限轮播图组件` `轮播组件` `无限图片轮播` `无限文字轮播`




使用方法

* `GHCarouselMap`拖到项目内,在要使用的控制器包含```#import "GHCarouselMap.h"```


* 遵守协议`GHCarouselMapDelegate` `GHCarouselMapDataSource`


* 实现协议

  ```
  /// 返回轮播view个数
  - (NSInteger)countOfCellForCarouselMap:(GHCarouselMap *)carouselMap
  
  /// 返回view
  - (UIView *)carouselMap:(GHCarouselMap *)carouselMap cellAtIndex:(NSInteger)index
  
  ```


* 代理方法

  ```
  /// 返回轮播当前被点击的index
  - (void)carouselMap: (GHCarouselMap *) carouselMap didSelectRowAtIndex:(NSInteger)index 

  ```
 
`- (void)reloadData` 外部提供对象方法,下载图片完成后刷新轮播图
 
 
 
 
 ***录制gif存在丢帧现象请以真机调试效果为主***
 
![Untitled.gif](https://upload-images.jianshu.io/upload_images/1419035-82fc1c2bbb836689.gif?imageMogr2/auto-orient/strip)

---


### 在使用中如有任何问题欢迎骚扰我,如果对你有帮助请点帮我一个✨,小弟感激不尽:blush: