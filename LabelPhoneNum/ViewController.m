//
//  ViewController.m
//  LabelPhoneNum
//
//  Created by 黄坤 on 16/11/10.
//  Copyright © 2016年 jiayou9. All rights reserved.
//

#import "ViewController.h"
#import "YYText.h"
#import <TTTAttributedLabel.h>
#import "AppDelegate.h"
#import "CallPhone.h"
#import "NSString+stringDeleString.h"
@interface ViewController ()
@property (nonatomic,strong) YYLabel *kflbl;
@property (nonatomic,copy) NSString * phoneNum;
// 要在出发呼叫功能前不被release需要强引用
@property (nonatomic,strong) UIWebView *phoneCallWebView;
@end

#define KEFU @"收不到短信？ 请拨打客服"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LabelPhoneNum";
    [self setupUI];
    [self creatString:@"010-53397335"];
}
#pragma mark - 创建可变字符串
- (void)creatString:(NSString *)phoneNum {
    // 创建可变字符串
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:KEFU];
    [text yy_setFont:[UIFont systemFontOfSize:20] range:text.yy_rangeOfAll];//字体
    text.yy_lineSpacing = 20;//行间距
    
    UIColor *colorNormal = [UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000];
    UIColor *colorHighlight = [UIColor purpleColor];
    
    NSRange range9 = [[text string] rangeOfString:@"客服" options:NSCaseInsensitiveSearch];
    
    
    YYTextDecoration *decorationNomal = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle
                                                                        width:@(1)
                                                                        color:colorNormal];
    YYTextDecoration *decorationHighlight = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle
                                                                            width:@(1)
                                                                            color:colorHighlight];
    //未点击时颜色
    [text yy_setColor:colorNormal range:range9];
    //未点击时下划线
    [text yy_setTextUnderline:decorationNomal range:range9];
    
    //点击后的状态
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setColor:colorHighlight];
    [highlight setUnderline:decorationHighlight];
    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        // 删除电话字符串中的"-"
        NSString *deleNum = [NSString stringDeleteString:phoneNum];
        self.phoneNum = deleNum;
#warning 电话方法一
        [self telPhoneNum:phoneNum];
#warning 电话方法二、三
//        [CallPhone callPhoneTwo:deleNum];
//        [self callPhoneThree:deleNum];
        
        
        
    };
    [text yy_setTextHighlight:highlight range:range9];
    
    self.kflbl.attributedText = text;
    
}
#pragma mark - 拨号方法三，会稍微慢于前两种方法
- (void)callPhoneThree:(NSString *)phoneNum{
    /*--------拨号方法三-----------*/
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
    if ( !_phoneCallWebView ) {
        
        _phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    
}

#pragma mark - 弹窗
- (void)telPhoneNum:(NSString *)phoneNum {
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *delegate = (AppDelegate *)application.delegate;
    UIWindow *window = delegate.window;
    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:phoneNum preferredStyle:UIAlertControllerStyleAlert];
    
    // Action
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 此处适用于方法一手动弹窗
        [CallPhone callPhoneOne:self.phoneNum];
    }];
    
    [alert addAction:actionCancel];
    [alert addAction:actionDone];
    
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}
- (void)setupUI {
    YYLabel *kf = [YYLabel new];
    
    kf.frame = CGRectMake(30, 300, 315, 30);
    
    kf.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:kf];
    
    _kflbl = kf;
}

@end
