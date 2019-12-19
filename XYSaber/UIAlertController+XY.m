//
//  UIAlertController+XY.m
//  XYKit
//
//  Created by lxy on 2019/1/17.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "UIAlertController+XY.h"
#import "XYApp.h"
@implementation UIAlertController (XY)
+(void)xy_showSheetWithTitle:(NSString*)title message:(NSString*)message titles:(NSArray*)titles handleBlock:(void(^)(UIAlertAction *action))handleBlock{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *title in titles) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        NSString *handledTitle = title;
        
        if ([title hasPrefix:@"c_"]) {
            style = UIAlertActionStyleCancel;
            handledTitle = [title substringFromIndex:2];
        }else if ([title hasPrefix:@"d_"]){
            style = UIAlertActionStyleDestructive;
            handledTitle = [title substringFromIndex:2];
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:handledTitle style:style handler:^(UIAlertAction * _Nonnull action) {
            handleBlock(action);
        }];
        [actionSheet addAction:action];
    }
    [XYApp.currentViewController presentViewController:actionSheet animated:YES completion:nil];
}

+(void)xy_showAlertWithTitle:(NSString*)title message:(NSString*)message titles:(NSArray*)titles numOfTextField:(NSInteger)numOfTestField textFieldBlock:(void(^)(UITextField *textField,NSInteger index))textFieldBlock handleBlock:(void(^)(UIAlertAction *action,NSInteger index,NSArray *textFields))handleBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (int i = 0; i < numOfTestField; i++) {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textFieldBlock(textField,i);
        }];
    }
    
    for (NSString *title in titles) {
        NSInteger index = [titles indexOfObject:title];
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        NSString *handledTitle = title;
        if ([title hasPrefix:@"c_"]) {
            style = UIAlertActionStyleCancel;
            handledTitle = [title substringFromIndex:2];
        }else if ([title hasPrefix:@"d_"]){
            style = UIAlertActionStyleDestructive;
            handledTitle = [title substringFromIndex:2];
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:handledTitle style:style handler:^(UIAlertAction * _Nonnull action) {
            handleBlock(action,index,alert.textFields);
        }];
        [alert addAction:action];
    }
    [XYApp.currentViewController presentViewController:alert animated:YES completion:nil];
}
@end
