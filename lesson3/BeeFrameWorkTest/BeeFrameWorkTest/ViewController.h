//
//  ViewController.h
//  BeeFrameWorkTest
//
//  Created by he songhang on 13-6-3.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BeeFramework/Bee.h>

@interface MyCell : UITableViewCell{
    UILabel *lb_content;
    UIButton *btn_count;
    UIButton *btn_comment;
}

@property(nonatomic,retain) NSDictionary *data;

AS_SIGNAL(COUNT)

AS_SIGNAL(COMMENT)


@end

@interface ViewController : UITableViewController

@end
