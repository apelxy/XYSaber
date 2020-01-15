//
//  XYMedia.m
//  XYKit
//
//  Created by lxy on 2020/1/15.
//  Copyright © 2020 ios. All rights reserved.
//

#import "XYMedia.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@implementation XYMedia
// 获取视频第一帧
+(UIImage*)getVideoPreViewImage:(NSString *)path{

    //本地视频
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:path] options:nil];

    //网络视频
    AVURLAsset *asset2 = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:path] options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    if (videoImage == nil) {
        videoImage = [UIImage new];
    }

    return videoImage;
}
@end
