//
//  XYObjectSupport.h
//  XYKit
//
//  Created by ios on 2019/4/23.
//  Copyright © 2019 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^XYNotificationBlock)(NSNotification *notification);
typedef void(^XYObserveBlock)(NSDictionary<NSKeyValueChangeKey,id> *change);

@interface XYObjectSupport : NSObject

@property (nonatomic,strong) NSMutableArray *blockArray;
@property (nonatomic,strong) NSMutableArray *observeArray;

@end


