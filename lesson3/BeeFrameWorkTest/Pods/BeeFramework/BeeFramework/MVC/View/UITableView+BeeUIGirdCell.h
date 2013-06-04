//
//  UITableView+BeeUIGirdCell.h
//  618
//
//  Created by he songhang on 13-4-24.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import <Foundation/Foundation.h>
#import "Bee_UIGridCell.h"

@interface UITableViewCell (BeeUIGirdCell)
@property(nonatomic,retain) BeeUIGridCell *gridCell;
@end

@interface UITableView (BeeUIGirdCell)
-(UITableViewCell *) dequeueReusableCellWithBeeUIGirdCellClass:(Class) class;
@end
#endif