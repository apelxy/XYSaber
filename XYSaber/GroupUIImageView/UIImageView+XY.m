//
//  UIImageView+XY.m
//  XYUserTool
//
//  Created by lxy on 2019/1/11.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "UIImageView+XY.h"
#import "NSThread+XY.h"
#import <objc/runtime.h>
#import "XYMacro.h"
#import "XYImageViewSupport.h"
#import "XYApp.h"
#import "XYMedia.h"
#import "UIButton+XY.h"
#import "UIView+XY.h"
@interface UIImageView ()
@property (nonatomic,copy) NSString *url;
@property (nonatomic,strong) UIButton *actionBtn;
@end

static UIButton *actionBtn_id = nil;
@implementation UIImageView (XY)
#pragma mark 加载网略图
-(void)xy_setImageWithUrl:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage{

    self.url = url;
    UIImage *image = [XYImageViewSupport shared].imageDic[url];
    if (image) {
        //从内存查找
        self.image = image;
    }else{
        
        //从沙盒查找
        NSString *sandboxPath = [NSString stringWithFormat:@"%@/%@",XYApp.documentPath,[XYImageViewSupport shared].sandboxPath];
        NSString *sandboxImageUrl = [NSString stringWithFormat:@"%@/%@",sandboxPath,[url stringByReplacingOccurrencesOfString:@"/" withString:@"-"]];
        UIImage *sandboxImage = [UIImage imageWithContentsOfFile:sandboxImageUrl];
        
        if (sandboxImage) {
            self.image = sandboxImage;
            //存到内存
            [[XYImageViewSupport shared].imageDic setObject:sandboxImage forKey:url];
        }else{
            self.image = placeHolderImage;
            //从网络获取
            [NSThread xy_createGlobalThread:^{
                NSDictionary *imageInfo = [self getImageInfoWithUrl:url];
                UIImage *netImage = imageInfo[@"image"];
                NSString *netUrl = imageInfo[@"url"];
                
                [NSThread xy_backToMainThread:^{
                    if (netImage) {
                        //存到内存
                        [[XYImageViewSupport shared].imageDic setObject:netImage forKey:netUrl];
                        //放到沙盒
                        NSData *netImageData = imageInfo[@"data"];
                        [self saveToSandboxWithSandboxPath:sandboxPath url:sandboxImageUrl data:netImageData];
                        //只显示最后一次设置的图片
                        if ([netUrl isEqualToString:self.url]) {
                            self.image = netImage;
                        }
                    }
                }];
            }];
        }
    }
}
-(NSDictionary*)getImageInfoWithUrl:(NSString*)url{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *urlImage = [UIImage imageWithData:data];
    
    return @{
        @"data":data,
        @"image":urlImage,
        @"url":url
    };
}

#pragma mark 加载视频缩略图
-(void)xy_setImageWithLocalVideo:(NSString*)videoPath placeHolderImage:(UIImage*)placeHolderImage{

    self.url = videoPath;
    UIImage *image = [XYImageViewSupport shared].imageDic[videoPath];
    if (image) {
        //从内存查找
        self.image = image;
    }else{
        
        //从沙盒查找
        NSString *sandboxPath = [NSString stringWithFormat:@"%@/%@",XYApp.documentPath,[XYImageViewSupport shared].sandboxPath];
        NSString *sandboxImageName = videoPath.lastPathComponent;
        NSString *sandboxImageUrl = [NSString stringWithFormat:@"%@/%@",sandboxPath,sandboxImageName];
        sandboxImageUrl = [sandboxImageUrl stringByReplacingOccurrencesOfString:sandboxImageUrl.pathExtension withString:@"png"];
        UIImage *sandboxImage = [UIImage imageWithContentsOfFile:sandboxImageUrl];
        
        if (sandboxImage) {
            self.image = sandboxImage;
            //放到内存
            [[XYImageViewSupport shared].imageDic setObject:sandboxImage forKey:videoPath];
        }else{
            self.image = placeHolderImage;
            //从视频获取
            [NSThread xy_createGlobalThread:^{
                NSDictionary *imageInfo = [self getImageInfoWithVideo:videoPath];
                UIImage *netImage = imageInfo[@"image"];
                NSString *videoPath = imageInfo[@"url"];
                
                [NSThread xy_backToMainThread:^{
                    if (netImage) {
                        //存到内存
                        [[XYImageViewSupport shared].imageDic setObject:netImage forKey:videoPath];
                        //放到沙盒
                        NSData *netImageData = imageInfo[@"data"];
                        [self saveToSandboxWithSandboxPath:sandboxPath url:sandboxImageUrl data:netImageData];
                        //只显示最后一次设置的图片
                        if ([videoPath isEqualToString:self.url]) {
                            self.image = netImage;
                        }
                    }
                }];
            }];
        }
    }
}

-(void)saveToSandboxWithSandboxPath:(NSString*)sandboxPath url:(NSString*)url data:(NSData*)data{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:sandboxPath]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:sandboxPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    BOOL save =[data writeToFile:url atomically:YES];
}
-(NSDictionary*)getImageInfoWithVideo:(NSString*)videoPath{
    
    UIImage *urlImage = [XYMedia getVideoPreViewImage:videoPath];
    NSData *data = UIImagePNGRepresentation(urlImage);

    return @{
        @"data":data,
        @"image":urlImage,
        @"url":videoPath
    };
}

+(void)cleanXYImageCache{
    
    NSString *sandboxPath = [NSString stringWithFormat:@"%@/%@",XYApp.documentPath,[XYImageViewSupport shared].sandboxPath];
    [[NSFileManager defaultManager]removeItemAtPath:sandboxPath error:nil];
}




-(void)xy_addActionExtend:(UIEdgeInsets)actionExtend action:(void(^)(void))action{
    self.userInteractionEnabled = YES;

    CGFloat left = actionExtend.left;
    CGFloat right = actionExtend.right;
    CGFloat top = actionExtend.top;
    CGFloat bottom = actionExtend.bottom;
    
    self.actionBtn.frame = CGRectMake(-left, -top, self.width + left + right, self.height + top + bottom);
    self.actionBtn.action = ^(UIButton *button) {
        action();
    };
    [self addSubview:self.actionBtn];
}

-(UIButton*)actionBtn{
    UIButton *btn = objc_getAssociatedObject(self, &actionBtn_id);
    if (!btn) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        objc_setAssociatedObject(self, &actionBtn_id, btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return btn;
}


#if 1
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *object_view = nil;
    NSArray *subAry = self.subviews;
    for (UIView *sub in subAry) {
        if (sub.x < 0 || sub.y < 0 || sub.maxX > self.width || self.maxY > self.height) {
            object_view = sub;
            break;
        }
    }
    UIView *view = [super hitTest:point withEvent:event];
    CGPoint tempPoint = [object_view convertPoint:point fromView:self];
    if ([object_view pointInside:tempPoint withEvent:event]) {
        return object_view;
    }
    return view;
}
#endif

#pragma mark 属性
static NSString *url_id = nil;
-(void)setUrl:(NSString *)url{
    objc_setAssociatedObject(self, &url_id, url, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)url{
    return objc_getAssociatedObject(self, &url_id);
}
@end
