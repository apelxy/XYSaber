//
//  XYHint.m
//  XYUserTool5
//
//  Created by lxy on 2019/1/3.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "XYHint.h"
#import "UIView+XY.h"
#import "XYTimer.h"

@interface XYHint ()
@property (nonatomic,strong) UIView *inView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,assign) BOOL loading;
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;
@property (nonatomic,strong) UILabel *msgLabel;

@end

@implementation XYHint
-(instancetype)initWithView:(UIView *)view loading:(BOOL)loading{
    
    self = [super initWithFrame:CGRectMake(0, 0, view.width, view.height)];
    if (self) {
        self.inView = view;
        self.loading = loading;
        
    }
    return self;
}
-(UIView*)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.8];
        _contentView.layer.cornerRadius = 3;
        [self addSubview:_contentView];
    }
    return _contentView;
}
-(UIActivityIndicatorView*)loadingView{
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _loadingView.color = [UIColor whiteColor];
        _loadingView.backgroundColor = [UIColor clearColor];
        [_loadingView startAnimating];
    }
    return _loadingView;
}
-(UILabel*)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        _msgLabel.text = self.message;
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        _msgLabel.textColor = [UIColor whiteColor];
        _msgLabel.numberOfLines = 0;
        _msgLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_msgLabel];
    }
    return _msgLabel;
}
-(void)setText:(NSString *)text{
    _text = text;
    
    self.msgLabel.text = self.text;
    self.msgLabel.y = _loadingView.maxY + 5;
    self.msgLabel.width = [self contentSize:self.text].width + 50;
    self.msgLabel.height = [self contentSize:self.text].height;
    
    self.contentView.width = self.msgLabel.width;
    self.contentView.height = self.msgLabel.maxY + 10;
    self.contentView.midX = self.width / 2;
    self.contentView.midY = self.height / 2;
    
    _loadingView.midX = self.contentView.width / 2;
    
}
-(void)setLoading:(BOOL)loading{
    _loading = loading;
    if (_loading) {
        [self.contentView addSubview:self.loadingView];
        self.loadingView.y = 10;
        self.contentView.height = self.loadingView.maxY+10;
        self.contentView.width = self.loadingView.width+60;
        self.loadingView.midX = self.contentView.width / 2;
        
        self.contentView.midX = self.width / 2;
        self.contentView.midY = self.height / 2;
    }
}
-(void)show{
    
    
    [self.inView addSubview:self];
    
    if (self.endTime) {
        [XYTimer countdownWithTotalTime:self.endTime timeInterval:1 handler:^(XYTimer *timer, NSTimeInterval time) {
            if (time == 0) {
                [self end];
            }
        }];
        
    }
}

-(void)end{
    [self removeFromSuperview];
}
-(CGSize)contentSize:(NSString*)content{
    //关键语句
    CGSize expectSize = [content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width*.8, [UIScreen mainScreen].bounds.size.height*.8) lineBreakMode:NSLineBreakByClipping];
    return expectSize;
}
-(void)dealloc{

}
@end
