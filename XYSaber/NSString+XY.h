//
//  NSString+XY.h
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (XY)

-(NSString*)xy_asciiToStringWithSeparateString:(NSString*)separateString camouflage:(NSString*)camouflage;
-(NSString*)xy_stringToAsciiWithSeparateString:(NSString*)separateString camouflage:(NSString*)camouflage;

-(NSRange)xy_lastRangeOfString:(NSString*)string;

-(NSString*)xy_insertString:(NSString*)aString atIndex:(NSInteger)loc;

-(NSString*)xy_subStringToString:(NSString*)string include:(BOOL)include;
-(NSString*)xy_subStringFromString:(NSString*)string include:(BOOL)include;
-(NSString*)xy_subStringWithBeginString:(NSString*)beginString includeBegin:(BOOL)includeBegin endString:(NSString*)endString includeEnd:(BOOL)includeEnd;

-(NSDictionary*)xy_urlParametersToDictionary:(NSString*)urlParametersString;

-(NSData*)xy_dataValue;
-(NSDictionary*)xy_jsonToDictionary;

@end


