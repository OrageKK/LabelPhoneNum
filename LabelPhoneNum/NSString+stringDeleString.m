//
//  NSString+stringDeleString.m
//  LabelPhoneNum
//
//  Created by 黄坤 on 16/11/10.
//  Copyright © 2016年 jiayou9. All rights reserved.
//

#import "NSString+stringDeleString.h"

@implementation NSString (stringDeleString)
+(NSString *) stringDeleteString:(NSString *)str
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if ( c == '"' || c == '.' || c == '-' || c == '(' || c == ')') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}
@end
