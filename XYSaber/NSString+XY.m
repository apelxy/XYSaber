//
//  NSString+XY.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "NSString+XY.h"
#import <objc/runtime.h>

static NSMutableAttributedString *mutableAttributedString_id = nil;
@implementation NSString (XY)

-(NSString*)xy_asciiToStringWithSeparateString:(NSString*)separateString camouflage:(NSString*)camouflage{
    int camouflageAsciiValue = [camouflage characterAtIndex:0];
    
    NSArray *charIndex = [self componentsSeparatedByString:separateString];
    NSString *resString = @"";
    for (int i = 0; i < charIndex.count; i++) {
        unichar ch = ([charIndex[i]integerValue] - 13 - camouflageAsciiValue * 7) / 3 - camouflageAsciiValue;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        str = [NSString stringWithFormat:@"%C",ch];
        resString = [resString stringByAppendingString:str];
    }
    return resString;
}
-(NSString*)xy_stringToAsciiWithSeparateString:(NSString*)separateString camouflage:(NSString*)camouflage{
    int camouflageAsciiValue = [camouflage characterAtIndex:0];
    
    NSString *resString = @"";
    for (int i = 0; i < self.length; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        int asciiValue = [str characterAtIndex:0];
        resString = [resString stringByAppendingString:[NSString stringWithFormat:@"%d",(asciiValue + camouflageAsciiValue) * 3 + camouflageAsciiValue * 7 + 13]];
        if (i < self.length - 1) {
            resString = [resString stringByAppendingString:separateString];
        }
    }
    return  resString;
}

-(NSRange)xy_lastRangeOfString:(NSString*)string{
    int index = -1;
    for (int i = 0; i < self.length - string.length + 1; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, string.length)];
        if ([str isEqualToString:string]) {
            index = i;
        }
    }
    return NSMakeRange(index, string.length);
}
-(NSString*)xy_insertString:(NSString*)aString atIndex:(NSInteger)loc{
    NSMutableString *mulString = [self mutableCopy];
    [mulString insertString:aString atIndex:loc];
    return [mulString copy];
}


-(NSString*)xy_subStringToString:(NSString*)string include:(BOOL)include{
    NSRange range = [self rangeOfString:string];
    if (range.location == NSNotFound) {
        return @"";
    }
    NSInteger toIndex = include?range.location+string.length:range.location;
    NSString *newString = [self substringToIndex:toIndex];
    return newString;
}
-(NSString*)xy_subStringFromString:(NSString*)string include:(BOOL)include{
    NSRange range = [self rangeOfString:string];
    if (range.location == NSNotFound) {
        return @"";
    }
    NSInteger fromIndex = include?range.location:range.location + range.length;
    NSString *newString = [self substringFromIndex:fromIndex];
    return newString;
}
-(NSString*)xy_subStringWithBeginString:(NSString*)beginString includeBegin:(BOOL)includeBegin endString:(NSString*)endString includeEnd:(BOOL)includeEnd{
    NSRange beginRange = [self rangeOfString:beginString];
    NSRange endRange = [self rangeOfString:endString];
    if (beginRange.location == NSNotFound || endRange.location == NSNotFound) {
        return @"";
    }
    NSInteger originalLength = -1;
    if (includeBegin && includeEnd) {
        originalLength = endRange.location - beginRange.location + endString.length;
    }else if (includeBegin && !includeEnd){
        originalLength = endRange.location - beginRange.location;
    }else if (!includeBegin && includeEnd){
        originalLength = endRange.location - beginRange.location - beginString.length + endString.length;
    }else if (!includeBegin && !includeEnd){
        originalLength = endRange.location - beginRange.location - beginString.length;
    }
    
    NSString *newString = [self substringWithRange:NSMakeRange(includeBegin?beginRange.location:beginRange.location + beginString.length,originalLength)];
    return newString;
}
-(NSDictionary*)xy_urlParametersToDictionary:(NSString*)urlParametersString{
    NSMutableDictionary *mulDic = [NSMutableDictionary dictionary];
    NSArray *parameterArray = [urlParametersString componentsSeparatedByString:@"&"];
    for (int i = 0; i < parameterArray.count; i++) {
        NSString *parameterStr = parameterArray[i];
        NSString *key = [parameterStr xy_subStringToString:@"=" include:NO];
        NSString *value = [parameterStr xy_subStringFromString:@"=" include:NO];
        [mulDic setObject:value forKey:key];
    }
    return [mulDic copy];
}

-(NSData*)xy_dataValue{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSDictionary*)xy_jsonToDictionary{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}



@end
