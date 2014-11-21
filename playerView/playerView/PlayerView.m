//
//  PlayerView.m
//  playerView
//
//  Created by Peter Lee on 14/11/20.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import "PlayerView.h"
#import "KeepLayout.h"

#define VIEW_END_X(View) (View.frame.origin.x + View.frame.size.width)
#define VIEW_END_Y(View) (View.frame.origin.y + View.frame.size.height)

#define STATUS_HEIGHT 20.0f

#define MARGIN_WIDTH 2.0f

#define ROW_NUM 7
#define BUTTON_MARGIN_WIDTH 8.0f

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define PLAYER_VIEW_WIDTH SCREEN_BOUNDS.size.width
#define PLAYER_VIEW_HEIGHT  88.0f

#define BAR_WIDTH PLAYER_VIEW_WIDTH
#define BAR_HEIGHT 44.0f

#define BUTTON_HEIGHT (BAR_HEIGHT - 2 * MARGIN_WIDTH)
#define BUTTON_WIDTH (BAR_WIDTH - (ROW_NUM + 1) * BUTTON_MARGIN_WIDTH)/ROW_NUM

#define SELF_WIDTH PLAYER_VIEW_WIDTH
#define SELF_HEIGHT (2 * 44 + PLAYER_VIEW_HEIGHT)

@implementation PlayerView
- (instancetype)init
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, SELF_WIDTH, SELF_HEIGHT);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initParameters];
    }
    return self;
}

- (void)initParameters
{
    [self initUI];
    [self initData];
}

- (void)initUI
{
    /*****************init the topBarView*******************/
    self.topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT)];
    self.topBarView.backgroundColor = [UIColor yellowColor];
    self.topBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.topBarView];
    
    //init the close button
    self.closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.closeButton.frame = CGRectMake(BUTTON_MARGIN_WIDTH, MARGIN_WIDTH, BUTTON_WIDTH, BUTTON_HEIGHT);
    [self.closeButton addTarget:self action:@selector(closeButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton setSelected:NO];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"power_sel"] forState:UIControlStateSelected];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.closeButton setTintColor:[UIColor clearColor]];
    [self.closeButton setUserInteractionEnabled:YES];
//    [self.closeButton setBackgroundColor:[UIColor whiteColor]];
    [self.topBarView addSubview:self.closeButton];
    
    /*****************init the playerView*******************/
    self.playerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BAR_HEIGHT,PLAYER_VIEW_WIDTH,PLAYER_VIEW_HEIGHT)];
    self.playerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
#warning this is the test code
    self.playerView.image = [UIImage imageNamed:@"通用头像"];
    self.playerView.contentMode = UIViewContentModeScaleAspectFit;
    self.playerView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.playerView];
    
    /*****************init the bottomBarView*******************/
    self.bottomBarView = [[UIView alloc] initWithFrame:CGRectMake(0, BAR_HEIGHT+PLAYER_VIEW_HEIGHT, BAR_WIDTH, BAR_HEIGHT)];
    self.bottomBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    self.bottomBarView.backgroundColor = [UIColor redColor];
    [self addSubview:self.bottomBarView];
    
    [self setupConstraints];
    [self showBars:YES];
}

- (void)initData
{
    self.backgroundColor = [UIColor blackColor];
}

-(void) setupConstraints
{
    
}
-(void) showBars:(BOOL)show
{
//    __weak __typeof(self) weakself = self;
//    if(show) {
//        CGRect frame = self.playerHudBottom.frame;
//        frame.origin.y = self.bounds.size.height;
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            weakself.playerHudBottom.frame = frame;
//            weakself.closeButton.layer.opacity = 0;
//            viewIsShowing = show;
//        }];
//    } else {
//        CGRect frame = self.playerHudBottom.frame;
//        frame.origin.y = self.bounds.size.height-self.playerHudBottom.frame.size.height;
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            weakself.playerHudBottom.frame = frame;
//            weakself.closeButton.layer.opacity = 1;
//            viewIsShowing = show;
//        }];
//    }
}

- (void)closeButtonCliked:(id)sender
{
    NSLog(@"YES,You cliked on me!");
}

@end
