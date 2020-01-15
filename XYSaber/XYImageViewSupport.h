//
//  XYImageViewSupport.h
//  XYKit
//
//  Created by lxy on 2020/1/15.
//  Copyright © 2020 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYImageViewSupport : NSObject
@property (nonatomic,strong) NSMutableDictionary *imageDic;

@property (nonatomic,copy) NSString *sandboxPath;

+(instancetype)shared;
@end

NS_ASSUME_NONNULL_END
