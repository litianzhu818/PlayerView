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
#define PLAYER_VIEW_HEIGHT  180.0f

#define BAR_WIDTH PLAYER_VIEW_WIDTH
#define BAR_HEIGHT 44.0f

#define BUTTON_HEIGHT (BAR_HEIGHT - 2 * MARGIN_WIDTH)
#define BUTTON_WIDTH (BAR_WIDTH - (ROW_NUM + 1) * BUTTON_MARGIN_WIDTH)/ROW_NUM

#define SELF_WIDTH PLAYER_VIEW_WIDTH
#define SELF_HEIGHT (2 * 44 + PLAYER_VIEW_HEIGHT)

@implementation PlayerView

- (void)dealloc
{
    [self.playerView removeGestureRecognizer:self.tapGesture];
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
}
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
    self.topBars = [NSMutableArray array];
    /*****************init the topBarView*******************/
    self.topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BAR_WIDTH, BAR_HEIGHT)];
//    self.topBarView.backgroundColor = [UIColor yellowColor];
    self.topBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.topBarView];
    
    //init the close button
    self.closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.closeButton.frame = CGRectMake(BUTTON_MARGIN_WIDTH, MARGIN_WIDTH, BUTTON_WIDTH, BUTTON_HEIGHT);
//    self.closeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    self.closeButton.tag = 1;
    [self.closeButton addTarget:self action:@selector(clikedOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton setSelected:NO];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"power_sel"] forState:UIControlStateSelected];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.closeButton setTintColor:[UIColor clearColor]];
    [self.closeButton setUserInteractionEnabled:YES];
    [self.topBarView addSubview:self.closeButton];
    [self.topBars addObject:self.closeButton];
    
    //the button1
    self.button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button1.frame = CGRectMake(BUTTON_MARGIN_WIDTH + VIEW_END_X(self.closeButton), MARGIN_WIDTH, BUTTON_WIDTH, BUTTON_HEIGHT);
//    self.button1.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    self.button1.tag = 2;
    [self.button1 addTarget:self action:@selector(clikedOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 setSelected:NO];
    [self.button1 setBackgroundImage:[UIImage imageNamed:@"power_sel"] forState:UIControlStateSelected];
    [self.button1 setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.button1 setTintColor:[UIColor clearColor]];
    [self.button1 setUserInteractionEnabled:YES];
    [self.topBarView addSubview:self.button1];
    [self.topBars addObject:self.button1];
    
    //the button2
    self.button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button2.frame = CGRectMake(BUTTON_MARGIN_WIDTH + VIEW_END_X(self.button1), MARGIN_WIDTH, BUTTON_WIDTH, BUTTON_HEIGHT);
//    self.button2.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    self.button2.tag = 3;
    [self.button2 addTarget:self action:@selector(clikedOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 setSelected:NO];
    [self.button2 setBackgroundImage:[UIImage imageNamed:@"power_sel"] forState:UIControlStateSelected];
    [self.button2 setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.button2 setTintColor:[UIColor clearColor]];
    [self.button2 setUserInteractionEnabled:YES];
    [self.topBarView addSubview:self.button2];
    [self.topBars addObject:self.button2];
    
    //the left_right
    self.left_right_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.left_right_btn.frame = CGRectMake(BUTTON_MARGIN_WIDTH + VIEW_END_X(self.button2), MARGIN_WIDTH, BUTTON_WIDTH, BUTTON_HEIGHT);
//    self.left_right_btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    self.left_right_btn.tag = 4;
    [self.left_right_btn addTarget:self action:@selector(clikedOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.left_right_btn setSelected:NO];
    [self.left_right_btn setBackgroundImage:[UIImage imageNamed:@"power_sel"] forState:UIControlStateSelected];
    [self.left_right_btn setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.left_right_btn setTintColor:[UIColor clearColor]];
    [self.left_right_btn setUserInteractionEnabled:YES];
    [self.topBarView addSubview:self.left_right_btn];
    [self.topBars addObject:self.left_right_btn];
    
    //the up_down_btn
    self.up_down_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.up_down_btn.frame = CGRectMake(BUTTON_MARGIN_WIDTH + VIEW_END_X(self.left_right_btn), MARGIN_WIDTH, BUTTON_WIDTH, BUTTON_HEIGHT);
//    self.up_down_btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    self.up_down_btn.tag = 5;
    [self.up_down_btn addTarget:self action:@selector(clikedOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.up_down_btn setSelected:NO];
    [self.up_down_btn setBackgroundImage:[UIImage imageNamed:@"power_sel"] forState:UIControlStateSelected];
    [self.up_down_btn setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.up_down_btn setTintColor:[UIColor clearColor]];
    [self.up_down_btn setUserInteractionEnabled:YES];
    [self.topBarView addSubview:self.up_down_btn];
    [self.topBars addObject:self.up_down_btn];
    
    //the turn_left_right_btn
    self.turn_left_right_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.turn_left_right_btn.frame = CGRectMake(BUTTON_MARGIN_WIDTH + VIEW_END_X(self.up_down_btn), MARGIN_WIDTH, BUTTON_WIDTH, BUTTON_HEIGHT);
//    self.turn_left_right_btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    self.turn_left_right_btn.tag = 6;
    [self.turn_left_right_btn addTarget:self action:@selector(clikedOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.turn_left_right_btn setSelected:NO];
    [self.turn_left_right_btn setBackgroundImage:[UIImage imageNamed:@"power_sel"] forState:UIControlStateSelected];
    [self.turn_left_right_btn setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.turn_left_right_btn setTintColor:[UIColor clearColor]];
    [self.turn_left_right_btn setUserInteractionEnabled:YES];
    [self.topBarView addSubview:self.turn_left_right_btn];
    [self.topBars addObject:self.turn_left_right_btn];
    
    
    //the turn_up_down_btn
    self.turn_up_down_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.turn_up_down_btn.frame = CGRectMake(BUTTON_MARGIN_WIDTH + VIEW_END_X(self.turn_left_right_btn), MARGIN_WIDTH, BUTTON_WIDTH, BUTTON_HEIGHT);
//    self.turn_up_down_btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    self.turn_up_down_btn.tag = 7;
    [self.turn_up_down_btn addTarget:self action:@selector(clikedOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.turn_up_down_btn setSelected:NO];
    [self.turn_up_down_btn setBackgroundImage:[UIImage imageNamed:@"power_sel"] forState:UIControlStateSelected];
    [self.turn_up_down_btn setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.turn_up_down_btn setTintColor:[UIColor clearColor]];
    [self.turn_up_down_btn setUserInteractionEnabled:YES];
    [self.topBarView addSubview:self.turn_up_down_btn];
    [self.topBars addObject:self.turn_up_down_btn];
    
    
    
    /*****************init the playerView*******************/
    self.playerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BAR_HEIGHT,PLAYER_VIEW_WIDTH,PLAYER_VIEW_HEIGHT)];
    self.playerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
#warning this is the test code
    self.playerView.image = [UIImage imageNamed:@"通用头像"];
    self.playerView.contentMode = UIViewContentModeScaleAspectFit;
    self.playerView.backgroundColor = [UIColor grayColor];
    self.playerView.userInteractionEnabled = YES;
    [self addSubview:self.playerView];
    
    self.noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(4*MARGIN_WIDTH, PLAYER_VIEW_HEIGHT - BAR_HEIGHT, 200, BAR_HEIGHT)];
    self.noticeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.noticeLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self.noticeLabel setText:@"请按住右边的麦克风进行语音对话"];
    [self.playerView addSubview:self.noticeLabel];
    
    self.talkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.talkButton.frame = CGRectMake(PLAYER_VIEW_WIDTH - 4*MARGIN_WIDTH - BAR_HEIGHT, PLAYER_VIEW_HEIGHT - BAR_HEIGHT, BAR_HEIGHT, BAR_HEIGHT);
    self.talkButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin| UIViewAutoresizingFlexibleTopMargin;
    [self.talkButton addTarget:self action:@selector(talkButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.talkButton setSelected:NO];
    [self.talkButton setBackgroundImage:[UIImage imageNamed:@"speak_pre"] forState:UIControlStateSelected];
    [self.talkButton setBackgroundImage:[UIImage imageNamed:@"speak_nor"] forState:UIControlStateNormal];
    [self.talkButton setTintColor:[UIColor clearColor]];
    [self.talkButton setUserInteractionEnabled:YES];
    [self.playerView addSubview:self.talkButton];
    
    
    /*****************init the bottomBarView*******************/
    self.bottomBarView = [[UIView alloc] initWithFrame:CGRectMake(0, BAR_HEIGHT+PLAYER_VIEW_HEIGHT, BAR_WIDTH, BAR_HEIGHT)];
    self.bottomBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
//    self.bottomBarView.backgroundColor = [UIColor redColor];
    [self addSubview:self.bottomBarView];
    
    
    [self setupConstraints];
    [self showBars:YES];
    [self hidenTalkViews:YES];
}

- (void)initData
{
    self.backgroundColor = [UIColor blackColor];
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clikedOnPlayerView:)];
    [self.playerView addGestureRecognizer:self.tapGesture];
    self.isFullScreen = NO;
    [self startTimer];
}

-(void) setupConstraints
{
    [self.topBars keepSizesEqual]; // 30 constraints
    self.topBars.keepInsets.min = BUTTON_MARGIN_WIDTH; // 64 constraints
    
    
    self.closeButton.keepLeftInset.equal = BUTTON_MARGIN_WIDTH;
    self.turn_up_down_btn.keepRightInset.equal = BUTTON_MARGIN_WIDTH;
    
    [self.topBars keepHorizontalOffsets:BUTTON_MARGIN_WIDTH +keepHigh];
    [self.topBars keepHorizontalAlignments:0 +keepHigh];

}
- (void)hidenBarsWhenShowing
{
    if (!self.isFullScreen) {
        [self showBars:NO];
    }
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
}

- (void)startTimer
{
    if (![self.timer isValid]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hidenBarsWhenShowing) userInfo:nil repeats:NO];
    }
}

- (void)clikedOnPlayerView:(UITapGestureRecognizer *)sender
{
    [self showBars:self.isFullScreen];
}
-(void) showBars:(BOOL)show
{
    __weak __typeof(self) weakself = self;
    if (self.isFullScreen) {//显示工具栏
        if (show) {
            CGRect playerFrame = self.playerView.frame;
            playerFrame.origin.y = BAR_HEIGHT;
            playerFrame.size.height = self.frame.size.height - 2*BAR_HEIGHT ;
            [UIView animateWithDuration:0.3 animations:^{
                weakself.topBarView.alpha = 1;
                weakself.bottomBarView.alpha = 1;
                weakself.playerView.frame = playerFrame;
                weakself.isFullScreen = !show;
            }];
        }
    }else{//影藏工具栏
        if(!show) {
            CGRect playerFrame = self.playerView.frame;
            playerFrame.origin = self.topBarView.frame.origin;
            playerFrame.size.height = self.frame.size.height;
            [UIView animateWithDuration:0.3 animations:^{
                weakself.topBarView.alpha = 0;
                weakself.bottomBarView.alpha = 0;
                weakself.playerView.frame = playerFrame;
                weakself.isFullScreen = !show;
            }];
        }
    }
}
- (void)hidenTalkViews:(BOOL)hiden
{
    [self.noticeLabel setHidden:hiden];
    [self.talkButton setHidden:hiden];
}

- (void)talkButtonCliked:(id)sender
{
    NSLog(@"YES,You cliked on me!");
}
- (void)clikedOnButton:(id)sender
{
    UIButton *btn = (UIButton *)sender;

    NSLog(@"YES,You cliked on me!  %d",btn.tag);
//    [self showBars:NO];
}

@end
