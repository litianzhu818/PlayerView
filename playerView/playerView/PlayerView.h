//
//  PlayerView.h
//  playerView
//
//  Created by Peter Lee on 14/11/20.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerView : UIView

@property (strong, nonatomic) UIView *topBarView;
@property (strong, nonatomic) UIView *bottomBarView;
@property (strong, nonatomic) UIImageView *playerView;

//buttons
@property (strong, nonatomic) UIButton *closeButton;

@end
