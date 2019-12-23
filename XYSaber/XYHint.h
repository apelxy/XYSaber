//
//  XYHint.h
//  XYUserTool5
//
//  Created by lxy on 2019/1/3.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XYHint : UIView
@property (nonatomic,assign) NSInteger endTime;

-(instancetype)initWithView:(UIView*)view message:(NSString*)message loading:(BOOL)loading;
-(void)show;
-(void)hide;
@end


