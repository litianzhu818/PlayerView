//
//  ViewController.h
//  playerView
//
//  Created by Peter Lee on 14/11/20.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"
@interface ViewController : UIViewController

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@property (strong, nonatomic) PlayerView *playerView;

@end

