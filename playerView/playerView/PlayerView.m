//
//  PlayerView.m
//  playerView
//
//  Created by Peter Lee on 14/11/20.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import "PlayerView.h"
#import "KeepLayout.h"

#define STATUS_HEIGHT 20.0f

@implementation PlayerView
- (instancetype)init
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    frame = [[UIScreen mainScreen] bounds];
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
    //The player view
    self.playerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT, <#CGFloat width#>, <#CGFloat height#>)];
}

- (void)initData
{
    self.backgroundColor = [UIColor blackColor];
}

-(void) setupConstraints
{
    
    // close button
}
@end
