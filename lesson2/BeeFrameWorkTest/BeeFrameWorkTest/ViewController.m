//
//  ViewController.m
//  BeeFrameWorkTest
//
//  Created by he songhang on 13-6-3.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "ViewController.h"

@implementation MyView

-(void)handleUISignal_BeeUIButton:(BeeUISignal *)signal{
    if ([signal is:BeeUIButton.TOUCH_UP_INSIDE]) {
        CC(@"MyView response");
    }
    [super handleUISignal:signal];
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleUISignal_BeeUIButton:(BeeUISignal *)signal{
    if ([signal is:BeeUIButton.TOUCH_UP_INSIDE]) {
        CC(@"ViewController response");
    }
}

@end
