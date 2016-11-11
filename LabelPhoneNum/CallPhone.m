//
//  CallPhone.m
//  LabelPhoneNum
//
//  Created by 黄坤 on 16/11/10.
//  Copyright © 2016年 jiayou9. All rights reserved.
//

#import "CallPhone.h"
#import "AppDelegate.h"
@implementation CallPhone
+(void)callPhoneOne:(NSString *)phoneNum{
    UIApplication *application = [UIApplication sharedApplication];
    /*--------拨号方法一-----------*/
    // 使用此方法，电话结束后进入联系人列表
    NSString *num1 = [NSString stringWithFormat:@"tel://%@",phoneNum];
    [application openURL:[NSURL URLWithString:num1] options:@{} completionHandler:^(BOOL success) {}];
}
+(void)callPhoneTwo:(NSString *)phoneNum{
    UIApplication *application = [UIApplication sharedApplication];
        /*--------拨号方法二-----------*/
        //这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
        NSString *num2 = [NSString stringWithFormat:@"telprompt://%@",phoneNum];
        [application openURL:[NSURL URLWithString:num2] options:@{} completionHandler:^(BOOL success) {}];
    
}

#pragma mark - 此方法放到了ViewController中，因为需要一个强引用

//+(void)callPhoneThree:(NSString *)phoneNum{
//        /*--------拨号方法三-----------*/
//        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
//        UIWebView *phoneCallWebView = [[UIWebView alloc] init];
//        if ( !phoneCallWebView ) {
//    
//            phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
//        }
//        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
//
//}




@end
