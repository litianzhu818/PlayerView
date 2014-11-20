//
//  ViewController.m
//  playerView
//
//  Created by Peter Lee on 14/11/20.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testmethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(NSStringFromCGRect(self.view.frame));
    [UIView animateWithDuration:duration animations:^{
        if(UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
            self.playerView.frame = CGRectMake(0, 0, self.height, self.width);
        } else {
            self.playerView.frame = CGRectMake(0, 0, self.width, self.height);
        }
    } completion:^(BOOL finished) {
        
    }];
}


- (void)testmethod
{
    self.width = self.view.frame.size.width;
    self.height = self.view.frame.size.height;
    self.playerView = [[PlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.playerView];
}

@end
