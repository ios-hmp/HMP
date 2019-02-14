//
//  LoadingView.m
//  Animations
//
//  Created by YouXianMing on 16/5/20.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LoadingView.h"

#import "UIView+AnimationProperty.h"
#import "InfiniteRotationView.h"
#import "UIView+GlowView.h"
#import "UIView+YYAdd.h"


static LoadingView *loadHud;
static LoadingView *msgHud;

@interface LoadingView ()
{
    NSTimer *loadT;
    NSTimer *msgT;
}
@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;

@property (nonatomic, assign)  BOOL    autoHiden;
@property (nonatomic, assign)  NSInteger    delayAutoHidenDuration;
@property (nonatomic, strong)  UILabel  *msgLable;
@property (nonatomic, strong)  UIView  *lableLayer;
@property (nonatomic, assign)  BOOL    isAnimationing;
@property (nonatomic, assign)  NSInteger type;//1  是加载等待视图   2 是显示提示信息视图
@property (nonatomic, assign)  BOOL    isfirst1;
@property (nonatomic, assign)  BOOL    isfirst2;

@end

@implementation LoadingView
+(LoadingView *)shareLoadHud{
    
    if (!loadHud) {
        loadHud = [[self alloc] initWithHudType:1];
        
    }
    return loadHud;
}
+(LoadingView *)shareMsgHud{
    
    if (!msgHud) {
        msgHud = [[self alloc] initWithHudType:2];
    }
    return msgHud;
}
-(instancetype)initWithHudType:(NSInteger)type{
    self=[super init];
    if (self) {
        _type = type;
       
        
        UIWindow *window=[[UIApplication sharedApplication].delegate window];
        [window addSubview:self];
        self.frame = CGRectMake(0, 0, 10, 10);
        self.center = window.center;
        self.hidden = YES;
        
        if (_type==1) {
            //laoding的
             [self createMessageView];
        }else{
            //msghud 的
            [self createMsgLableView];
            
        }
        
        //点击隐藏，避免长时间不会隐藏
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(animateHideHud)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)createMsgLableView{
    _msgLable = [[UILabel alloc]init];
    _msgLable.font = [UIFont systemFontOfSize:16];
    _msgLable.numberOfLines = 0;
    _msgLable.textColor = [UIColor colorWithRed:0.242 green:0.242 blue:0.242 alpha:1.0];
    _msgLable.textAlignment = NSTextAlignmentCenter;
    
    _lableLayer = [[UIView alloc]init];
    [self addSubview:_lableLayer];
    [self addSubview:_msgLable];

    _lableLayer.layer.shadowColor = [UIColor colorWithRed:0.3116 green:0.3116 blue:0.3116 alpha:1.0].CGColor;
    _lableLayer.layer.shadowRadius = 3;
    _lableLayer.layer.shadowOpacity = 0.4;
    _lableLayer.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.9545 blue:0.8964 alpha:1.0].CGColor;
    _lableLayer.layer.cornerRadius = 5;
    _lableLayer.layer.shadowOffset = CGSizeMake(0, 0);
    
    

    
}

- (void)createMessageView {
    
    // 创建信息窗体view
    self.messageView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LRectWidth, LRectWidth)];
    self.messageView.center              = self.center;
    self.messageView.layer.cornerRadius  = self.messageView.width / 2.f;
    self.messageView.layer.masksToBounds = YES;
    self.messageView.alpha               = 0.f;
    [self addSubview:self.messageView];
    self.messageView.center = CGPointMake(self.width*0.5, self.height*0.5);
    
    {
        InfiniteRotationView *rotateView = [[InfiniteRotationView alloc] initWithFrame:self.messageView.bounds];
        rotateView.speed                 = 0.95f;
        rotateView.clockWise             = YES;
        [rotateView startRotateAnimation];
        [self.messageView addSubview:rotateView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        imageView.image        = [UIImage imageNamed:@"myCline"];
        imageView.center       = rotateView.center;
        [rotateView addSubview:imageView];
    }
    
    UIImageView *inImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wordLoading"]];
    inImageView.scale        = 0.3f;
    [self.messageView addSubview:inImageView];
    inImageView.center = CGPointMake(self.messageView.bounds.size.width*0.5, self.messageView.bounds.size.height*0.5);
    
    // Start glow.
    inImageView.glowRadius            = @(2.f);
    inImageView.glowOpacity           = @(1.f);
    inImageView.glowColor             = [[UIColor colorWithRed:0.203  green:0.598  blue:0.859 alpha:1] colorWithAlphaComponent:0.95f];
    inImageView.glowDuration          = @(1.f);
    inImageView.hideDuration          = @(3.f);
    inImageView.glowAnimationDuration = @(1.f);
    [inImageView createGlowLayer];
    [inImageView insertGlowLayer];
    [inImageView startGlowLoop];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.messageView.alpha = 1.f;
        self.messageView.scale = 1.f;
    }];
}
//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color image:(UIImage *)orgimage
{
    UIGraphicsBeginImageContextWithOptions(orgimage.size, NO, orgimage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, orgimage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, orgimage.size.width, orgimage.size.height);
    CGContextClipToMask(context, rect, orgimage.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)showLoadHudAnimation{
 
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.hidden) {
            self.scale = 0.1;
        }
        self.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.scale = 1.0f;
            
        } completion:^(BOOL finished) {
            

        }];
        
        //最多显示30秒，之后隐藏
        [loadT invalidate];
        loadT = nil;
        loadT = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(animateHideHud) userInfo:nil repeats:NO];
        
    });
    
    
}

- (void)showMessage:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{

        
        
        _msgLable.text = msg;
        if (self.hidden) {
            _msgLable.frame = CGRectMake(0, 0, 1, 1);
            _msgLable.center = CGPointMake(self.width*0.5, self.height*0.5);
            _lableLayer.frame = _msgLable.frame;
        }
        self.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            
            _msgLable.width = 240;
            [_msgLable sizeToFit];
            _msgLable.center = CGPointMake(self.width*0.5, self.height*0.5);
            _lableLayer.width = _msgLable.width + 15;
            _lableLayer.height = _msgLable.height + 15;
            _lableLayer.center = _msgLable.center;

        }];
        [msgT invalidate];
        msgT = nil;
        msgT = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(animateHideHud) userInfo:nil repeats:NO];
        
    });
    
}
- (void)animateHideHud{
    [UIView animateWithDuration:0.3 animations:^{
        self.scale = 0.1f;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.scale = 1.0f;
    }];
}

#pragma mark - 类方法
//显示一个提示消息
+(void)showAMessage:(NSString *)msg{
    
    if (msg.length<1) {
        
    }else{
        UIWindow *window=[[UIApplication sharedApplication].delegate window];
        [window bringSubviewToFront:[self shareMsgHud]];

        [self shareMsgHud].center = CGPointMake(window.width*0.5, window.height*0.5);

        [[self shareMsgHud] showMessage:msg];
    }
    
    
}

//显示等待视图
+(void)showLoading{
    UIWindow *window=[[UIApplication sharedApplication].delegate window];
    [window bringSubviewToFront:[self shareLoadHud]];
    [self shareLoadHud].center = CGPointMake(window.width*0.5, window.height*0.5);
    [[self shareLoadHud] showLoadHudAnimation];
    
}
+(void)stopLoading {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[self shareLoadHud] animateHideHud];
    });
}
+(void)dismissAllHud{
    [[self shareLoadHud] animateHideHud];
    [[self shareMsgHud] animateHideHud];
}
@end
