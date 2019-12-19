//
//  UIAlertController+XY.h
//  XYKit
//
//  Created by lxy on 2019/1/17.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (XY)
+(void)xy_showSheetWithTitle:(NSString*)title message:(NSString*)message titles:(NSArray*)titles handleBlock:(void(^)(UIAlertAction *action))handleBlock;
+(void)xy_showAlertWithTitle:(NSString*)title message:(NSString*)message titles:(NSArray*)titles numOfTextField:(NSInteger)numOfTestField textFieldBlock:(void(^)(UITextField *textField,NSInteger index))textFieldBlock handleBlock:(void(^)(UIAlertAction *action,NSInteger index,NSArray *textFields))handleBlock;
@end


