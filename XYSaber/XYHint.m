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
@property (nonatomic,strong) UIView *view;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,assign) BOOL loading;


@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;
@property (nonatomic,strong) UILabel *msgLabel;

@property (nonatomic,strong) XYTimer *timer;
@end

@implementation XYHint
-(instancetype)initWithView:(UIView*)view message:(NSString*)message loading:(BOOL)loading{
    self = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    if (self) {
        
        self.view = view;
        self.message = message;
        self.loading = loading;
    }
    return self;
}

-(UIView*)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.8];
        _contentView.layer.cornerRadius = 3;
    }
    return _contentView;
}
-(UIActivityIndicatorView*)loadingView{
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        _loadingView.frame = CGRectMake(0, 0, 30, 30);
        _loadingView.color = [UIColor whiteColor];
        _loadingView.backgroundColor = [UIColor clearColor];
//        NSLog(@"%f",_loadingView.width);
        [_loadingView startAnimating];
    }
    return _loadingView;
}
-(UILabel*)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,[self contentSize:self.message].width + 50, [self contentSize:self.message].height)];
        _msgLabel.text = self.message;
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        _msgLabel.textColor = [UIColor whiteColor];
        _msgLabel.numberOfLines = 0;
        _msgLabel.font = [UIFont systemFontOfSize:15];
    }
    return _msgLabel;
}

-(void)show{
    
    if (_loading) {
        [self.contentView addSubview:self.loadingView];
        self.loadingView.y = 10;
        self.contentView.height = self.loadingView.maxY+10;
        self.contentView.width = self.loadingView.width+60;
        self.loadingView.midX = self.contentView.width / 2;
    }
    
    if (_message) {
        [self.contentView addSubview:self.msgLabel];
        self.msgLabel.y = _loadingView.maxY + 5;
        
        self.contentView.width = self.msgLabel.width;
        self.contentView.height = self.msgLabel.maxY + 10;
        
        _loadingView.midX = self.contentView.width / 2;
    }
    
    self.contentView.midX = self.width / 2;
    self.contentView.midY = self.height / 2;
    
    [self addSubview:self.contentView];
    [self.view addSubview:self];
    
    if (self.endTime) {
        [XYTimer countdownWithTotalTime:self.endTime timeInterval:1 handler:^(NSTimeInterval time) {
            if (time == 0) {
                [self hide];
            }
        }];
        
    }
}
-(void)xyTimer_time:(NSInteger)time{
//    NSLog(@"%ld",time);
    
}
-(void)hide{
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
