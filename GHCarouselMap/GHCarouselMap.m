//
//  GHCarouselMap.m
//  GHKit
//
//  Created by zhaozhiwei on 2019/2/6.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHCarouselMap.h"
#import "GHLoadImagesHelper.h"

@interface GHCarouselMap()<UIScrollViewDelegate,UITableViewDelegate>
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , assign) CGFloat preOffsetX;
@property (nonatomic , assign) CGFloat preOffsetY;
@property (nonatomic , assign) NSInteger pageCount;
@property (nonatomic , strong) UIPageControl *pageControl;  // 分页控件
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation GHCarouselMap

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame: frame]) {
        [self configuration];
    }
    return self;
}

- (instancetype)init {
    if (self == [super init]) {
        [self configuration];
    }
    return self;
}

- (void)configuration {
    self.scrollDirection = GHCarouselMapScrollDirectionHorizontal;
    self.timeInterval = 3.0;
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
}
- (void)setScrollDirection:(GHCarouselMapScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
}

- (void)reloadData {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(countOfCellForCarouselMap:)]) {
        self.pageCount = [self.dataSource countOfCellForCarouselMap:self];
    }
    
    if (self.scrollDirection == GHCarouselMapScrollDirectionHorizontal) {
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * (self.pageCount + 2), CGRectGetHeight(self.frame));
    } else {
        _scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.frame) * (self.pageCount + 2));
    }
    
    for (int i = 0; i < self.pageCount + 2; i++) {
        // 添加control,设置偏移位置
        CGFloat x = 0;
        CGFloat y = 0;
        if (self.scrollDirection == GHCarouselMapScrollDirectionHorizontal) {
            x = self.frame.size.width * i;
            y = 0;
            
        } else {
            _scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.frame) * (self.pageCount + 2));
            x = 0;
            y = self.frame.size.height * i;
            
        }
        
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(x,y, self.frame.size.width, self.frame.size.height)];
        
        UIView *pageView = nil;
        if (i == 0) {
            pageView = [self.dataSource carouselMap:self cellAtIndex:self.pageCount - 1];
        } else if (i == _pageCount + 1){
            pageView = [self.dataSource carouselMap:self cellAtIndex:0];
        }else{
            pageView = [self.dataSource carouselMap:self cellAtIndex:i - 1];
        }
        pageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        [control addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
        
        [control addSubview:pageView];
        
        [_scrollView addSubview:control];
    }
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self addSubview:self.scrollView];
    self.pageControl.currentPage = 0;
    if (self.scrollDirection == GHCarouselMapScrollDirectionVertical) {
        self.scrollView.contentOffset = CGPointMake(0,self.frame.size.height);
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(changePageBottom) userInfo:nil repeats:YES];

    } else {
        [self addSubview:self.pageControl];

        self.scrollView.contentOffset = CGPointMake(self.frame.size.width,0);
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(changePageLeft) userInfo:nil repeats:YES];

    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.preOffsetX = scrollView.contentOffset.x;
    self.preOffsetY = scrollView.contentOffset.y;
    [self.timer setFireDate:[NSDate distantFuture]];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.scrollDirection == GHCarouselMapScrollDirectionHorizontal) {
        CGFloat leftEdgeOffsetX = 0;
        CGFloat rightEdgeOffsetX = self.frame.size.width * (self.pageCount + 1);
        
        if (scrollView.contentOffset.x < self.preOffsetX){
            // 左滑
            if (scrollView.contentOffset.x > leftEdgeOffsetX) {
                self.pageControl.currentPage = scrollView.contentOffset.x / self.frame.size.width - 1;
            }
            else if (scrollView.contentOffset.x == leftEdgeOffsetX) {
                self.pageControl.currentPage = self.pageCount - 1;
            }
            
            if (scrollView.contentOffset.x == leftEdgeOffsetX) {
                self.scrollView.contentOffset = CGPointMake(self.frame.size.width * _pageCount, 0);
            }
        } else {
            if (scrollView.contentOffset.x < rightEdgeOffsetX) {
                self.pageControl.currentPage = scrollView.contentOffset.x / self.frame.size.width - 1;
            } else if (scrollView.contentOffset.x == rightEdgeOffsetX) {
                self.pageControl.currentPage = 0;
            }
            
            if (scrollView.contentOffset.x == rightEdgeOffsetX) {
                self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
            }
        }
    } else {
        
        CGFloat topEdgeOffsetY = 0;
        CGFloat bottomEdgeOffsetY = self.frame.size.height * (self.pageCount + 1);
        
        if (scrollView.contentOffset.y < self.preOffsetY){
            // 左滑
            if (scrollView.contentOffset.y > topEdgeOffsetY) {
                self.pageControl.currentPage = scrollView.contentOffset.y / self.frame.size.height - 1;
            }
            else if (scrollView.contentOffset.y == topEdgeOffsetY) {
                self.pageControl.currentPage = self.pageCount - 1;
            }
            
            if (scrollView.contentOffset.y == topEdgeOffsetY) {
                self.scrollView.contentOffset = CGPointMake(0,self.frame.size.height * _pageCount);
            }
        } else {
            // 右滑
            // 设置小点
            if (scrollView.contentOffset.y < bottomEdgeOffsetY) {
                self.pageControl.currentPage = scrollView.contentOffset.x / self.frame.size.height - 1;
            } else if (scrollView.contentOffset.y == bottomEdgeOffsetY) {
                self.pageControl.currentPage = 0;
            }
            
            if (scrollView.contentOffset.y == bottomEdgeOffsetY) {
                self.scrollView.contentOffset = CGPointMake(0,self.frame.size.height);
            }
        }
    }
    [self.timer setFireDate:[NSDate dateWithTimeInterval:self.timeInterval sinceDate:[NSDate date]]];
}

- (void)clickControl: (UIControl *)control {

    if (self.dalegate && [self.dalegate respondsToSelector:@selector(carouselMap:didSelectRowAtIndex:)]) {
        [self.dalegate carouselMap:self didSelectRowAtIndex:self.pageControl.currentPage];
    }
}
- (void)changePageBottom {
    // 设置当前需要偏移的量，每次递增一个page宽度
    CGFloat offsetY = _scrollView.contentOffset.y + CGRectGetHeight(self.frame);
    
    // 根据情况进行偏移
    CGFloat edgeOffsetY = self.frame.size.height * (_pageCount + 1);  // 最后一个多余页面右边缘偏移量
    
    // 从多余页往右边滑，赶紧先设置为第一页的位置
    if (offsetY > edgeOffsetY)
    {
        // 偏移量，不带动画，欺骗视觉
        self.scrollView.contentOffset = CGPointMake( 0,self.frame.size.height);
        // 这里提前改变下一个要滑动到的位置为第二页
        offsetY = self.frame.size.height * 2;
    }
    
    // 带动画滑动到下一页面
    [self.scrollView setContentOffset:CGPointMake(0,offsetY) animated:YES];
    if (offsetY < edgeOffsetY)
    {
        self.pageControl.currentPage = offsetY / self.frame.size.height - 1;
    }
    else if (offsetY == edgeOffsetY)
    {
        // 最后的多余那一页滑过去之后设置小点为第一个
        self.pageControl.currentPage = 0;
    }
}

- (void)changePageTop{
    // 设置当前需要偏移的量，每次递减一个page宽度
    CGFloat offsetY = _scrollView.contentOffset.y - CGRectGetHeight(self.frame);
    
    // 根据情况进行偏移
    CGFloat edgeOffsetY = 0;  // 最后一个多余页面左边缘偏移量
    
    // 从多余页往左边滑动，先设置为最后一页
    if (offsetY < edgeOffsetY) {
        self.scrollView.contentOffset = CGPointMake(0,self.frame.size.height * _pageCount);
        offsetY = self.frame.size.height * (_pageCount - 1);
    }
    
    // 带动画滑动到前一页面
    [self.scrollView setContentOffset:CGPointMake(0, offsetY) animated:YES];
    if (offsetY > edgeOffsetY) {
        self.pageControl.currentPage = offsetY / self.frame.size.height - 1;
    } else if (offsetY == edgeOffsetY) {
        // 最后的多余那一页滑过去之后设置小点为最后一个
        self.pageControl.currentPage = _pageCount - 1;
    }
}

// 往左边滑
- (void)changePageLeft {
    // 设置当前需要偏移的量，每次递减一个page宽度
    CGFloat offsetX = _scrollView.contentOffset.x - CGRectGetWidth(self.frame);
    
    // 根据情况进行偏移
    CGFloat edgeOffsetX = 0;  // 最后一个多余页面左边缘偏移量
    
    // 从多余页往左边滑动，先设置为最后一页
    if (offsetX < edgeOffsetX) {
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width * _pageCount, 0);
        offsetX = self.frame.size.width * (_pageCount - 1);
    }
    
    // 带动画滑动到前一页面
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    if (offsetX > edgeOffsetX) {
        self.pageControl.currentPage = offsetX / self.frame.size.width - 1;
    } else if (offsetX == edgeOffsetX) {
        // 最后的多余那一页滑过去之后设置小点为最后一个
        self.pageControl.currentPage = _pageCount - 1;
    }
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        self.pageCount = [self.dataSource countOfCellForCarouselMap:self];
        if (self.scrollDirection == GHCarouselMapScrollDirectionHorizontal) {
            _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * (self.pageCount + 2), CGRectGetHeight(self.frame));
        } else {
            _scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.frame) * (self.pageCount + 2));
        }
        
        _scrollView.delegate = self;
        for (int i = 0; i < self.pageCount + 2; i++) {
            // 添加control,设置偏移位置
            CGFloat x = 0;
            CGFloat y = 0;
            if (self.scrollDirection == GHCarouselMapScrollDirectionHorizontal) {
                x = self.frame.size.width * i;
                y = 0;

            } else {
                _scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.frame) * (self.pageCount + 2));
                x = 0;
                y = self.frame.size.height * i;

            }
            
            UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(x,y, self.frame.size.width, self.frame.size.height)];
            
            UIView *pageView = nil;
            if (i == 0) {
                pageView = [self.dataSource carouselMap:self cellAtIndex:self.pageCount - 1];
            } else if (i == _pageCount + 1){
                pageView = [self.dataSource carouselMap:self cellAtIndex:0];
            }else{
                pageView = [self.dataSource carouselMap:self cellAtIndex:i - 1];
            }
            pageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            
            [control addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
            
            [control addSubview:pageView];
            
            [_scrollView addSubview:control];
        }
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
        _pageControl.numberOfPages = _pageCount;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.enabled = YES ;
        [_pageControl setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
        //        [_pageControl addTarget:self action:@selector(pageControlTouched) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}


@end

