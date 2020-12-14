//
//  XYToast.m
//  XYKit
//
//  Created by lxy on 2020/12/11.
//  Copyright © 2020 ios. All rights reserved.
//

#import "XYToast.h"
#import "UIView+XY.h"
#define maxContentWidth [UIScreen mainScreen].bounds.size.width * .7
#define loadingViewHeight 50
#define textLeftRightGap    10
#define textFont [UIFont systemFontOfSize:17]

@interface XYToast ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation XYToast
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]init];
    }
    return _backView;
}
- (UIView *)blackView
{
    if (!_blackView) {
        _blackView = [[UIView alloc]init];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.layer.cornerRadius = 5;
    }
    return _blackView;
}
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _loadingView.frame = CGRectMake(0, 0, loadingViewHeight, loadingViewHeight);
        _loadingView.color = [UIColor whiteColor];
//        _loadingView.backgroundColor = [UIColor redColor];
        [_loadingView startAnimating];
    }
    return _loadingView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = textFont;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (void)showInView:(UIView *)aView
{
    self.contentHeight = textLeftRightGap;
    if (self.loading) {
        self.loadingView.y = self.contentHeight;
        [self.blackView addSubview:self.loadingView];
        self.contentHeight = CGRectGetMaxY(self.loadingView.frame) + textLeftRightGap;
        [self.blackView addSubview:self.loadingView];
//        self.loadingView.backgroundColor = [UIColor cyanColor];
    }
    
    if (self.text.length > 0) {
        
        CGSize aSize = [self.text sizeWithFont:textFont constrainedToSize:CGSizeMake(maxContentWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//        aSize = CGSizeMake(aSize.width + textLeftRightGap * 2, aSize.height + textLeftRightGap * 2);
        self.textLabel.frame = CGRectMake(0, self.contentHeight, aSize.width, aSize.height);
        self.textLabel.text = self.text;
//        self.textLabel.backgroundColor = [UIColor redColor];
        
        [self.blackView addSubview:self.textLabel];
        self.contentHeight = CGRectGetMaxY(self.textLabel.frame) + textLeftRightGap;
        [self.blackView addSubview:self.textLabel];
    }
    
    self.blackView.frame = CGRectMake(0, 0, [self getContentWidth] + textLeftRightGap * 2, self.contentHeight);
    self.loadingView.midX = self.blackView.width / 2;
    self.textLabel.midX = self.blackView.width / 2;
    [self.backView addSubview:self.blackView];
    
    if (self.fullScreen) {
        self.backView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }else{
        self.backView.frame = self.blackView.frame;
    }
//    self.backView.backgroundColor = [UIColor yellowColor];
    self.backView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    self.blackView.center = CGPointMake(self.backView.width / 2, self.backView.height / 2);
    [aView addSubview:self.backView];
    
    if (self.durationTime > 0) {
        [NSTimer scheduledTimerWithTimeInterval:self.durationTime target:self selector:@selector(timerAct:) userInfo:nil repeats:NO];
    }
}
- (void)stop{
    [self.backView removeFromSuperview];
}
- (void)timerAct:(NSTimer *)timer {
    [self.backView removeFromSuperview];
}
- (CGFloat)getContentWidth{
    CGFloat contWidth = 0;
    if (self.loading) {
        contWidth = CGRectGetWidth(self.loadingView.frame);
    }
    if (self.text.length > 0) {
        if (contWidth > 0) {
            contWidth = contWidth>CGRectGetWidth(self.textLabel.frame)?contWidth:CGRectGetWidth(self.textLabel.frame);
        }else{
            contWidth = CGRectGetWidth(self.textLabel.frame);
        }
    }
    
    return contWidth;
}

- (void)dealloc{
    
}
@end
