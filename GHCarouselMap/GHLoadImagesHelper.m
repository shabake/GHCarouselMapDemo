//
//  GHLoadImagesHelper.m
//  GHKit
//
//  Created by zhaozhiwei on 2019/2/6.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHLoadImagesHelper.h"
#define globalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)
#define mainQueue dispatch_get_main_queue()

@interface GHLoadImagesHelper()
@property (nonatomic , strong) NSMutableArray *images;
@end
@implementation GHLoadImagesHelper

+ (instancetype)sharedManager {
    
    static GHLoadImagesHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)loadImagesWithArray: (NSArray *)array actionBlock: (GHLoadImagesHelperBlock)actionBlock {
    
    NSURLSession *session = [NSURLSession sharedSession];
        
    for (NSInteger index = 0; index < array.count; index++) {
        NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:array[index]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                [self.images addObject:image];
                if(image != nil){
                    dispatch_async(mainQueue,^{
                        NSLog(@"图片下载成功");
                        actionBlock(self.images);
                    });
                } else{
                    NSLog(@"图片下载出现错误");
                }
            }
        }];
        [task resume];
    }
}

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}
@end
