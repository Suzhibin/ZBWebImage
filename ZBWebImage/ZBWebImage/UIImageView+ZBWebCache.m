//
//  UIImageView+ZBWebCache.m
//  ZBKit
//
//  Created by NQ UEC on 17/3/14.
//  Copyright © 2017年 Suzhibin. All rights reserved.
//

#import "UIImageView+ZBWebCache.h"

@implementation UIImageView (ZBWebCache)

- (void)zb_setImageWithURL:(NSString *)imageUrl{
    [self zb_setImageWithURL:imageUrl completion:nil];
}

- (void)zb_setImageWithURL:(NSString *)imageUrl placeholderImage:(UIImage *)placeholder{
    [self zb_setImageWithURL:imageUrl placeholderImage:placeholder path:nil];
}

- (void)zb_setImageWithURL:(NSString *)imageUrl placeholderImage:(UIImage *)placeholder path:(NSString *)path{
    [self zb_setImageWithURL:imageUrl placeholderImage:placeholder path:path completion:nil];
}

- (void)zb_setImageWithURL:(NSString *)imageUrl completion:(downloadCompletion)completion{
    [self zb_setImageWithURL:imageUrl placeholderImage:nil completion:completion];
}

- (void)zb_setImageWithURL:(NSString *)imageUrl placeholderImage:(UIImage *)placeholder completion:(downloadCompletion)completion{
    [self zb_setImageWithURL:imageUrl placeholderImage:placeholder path:[[ZBWebImageManager sharedInstance]imageFilePath] completion:completion];
}

- (void)zb_setImageWithURL:(NSString *)imageUrl placeholderImage:(UIImage *)placeholder path:(NSString *)path completion:(downloadCompletion)completion{
    if(placeholder){
        self.image=placeholder;
    }
    __weak __typeof(self)wself = self;
    [[ZBWebImageManager sharedInstance]downloadImageUrl:imageUrl path:path completion:^(UIImage *image){
        if (image) {
            wself.image=image;
            [wself setNeedsLayout];
        }else{
            wself.image=placeholder;
            [wself setNeedsLayout];
        }
        if (completion) {
            completion(image);
        }
    }];
    
}

@end
