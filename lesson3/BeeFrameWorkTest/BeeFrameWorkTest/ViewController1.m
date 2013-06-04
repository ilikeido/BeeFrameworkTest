//
//  ViewController1.m
//  BeeFrameWorkTest
//
//  Created by he songhang on 13-6-4.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "ViewController1.h"
#import <BeeFramework/UITableView+BeeUIGirdCell.h>
#import <BeeFramework/Bee.h>

@interface MYGirdCell : BeeUIGridCell{
    UILabel *lb_content;
    UIButton *btn_count;
    UIButton *btn_comment;
}

AS_SIGNAL(COUNT)
AS_SIGNAL(COMMENT)

@end

@implementation MYGirdCell

DEF_SIGNAL(COUNT)

DEF_SIGNAL(COMMENT)

//初始化
-(void)load{
    lb_content = [[UILabel alloc]init];
    btn_count = [[UIButton alloc]init];
    btn_comment = [[UIButton alloc]init];
    
    [btn_count addTarget:self action:@selector(countBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn_comment addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn_count setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn_count.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn_comment setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn_comment.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:lb_content];
    [self addSubview:btn_comment];
    [self addSubview:btn_count];
}

//释放
-(void)unload{
    
}

//数据变化时
- (void)dataDidChanged
{
    if (self.cellData) {
        NSDictionary *data = _cellData;
        lb_content.text = [data stringAtPath:@"content"];
        [btn_count setTitle:[NSString stringWithFormat:@"浏览(%@)",[data stringAtPath:@"count"]] forState:UIControlStateNormal];
        [btn_comment setTitle:[NSString stringWithFormat:@"评论(%@)",[data stringAtPath:@"comment"]] forState:UIControlStateNormal];
    }else{
        lb_content.text = nil;
        [btn_count setTitle:nil forState:UIControlStateNormal];
        [btn_comment setTitle:nil forState:UIControlStateNormal];
    }
}

//用于计算高度，可实现动态高度
+ (CGSize)sizeInBound:(CGSize)bound forData:(NSObject *)data
{
	return bound;
}

//用于布局
- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    lb_content.frame = CGRectMake(10, 0, 300, 44);
    btn_count.frame = CGRectMake(200, 20, 50, 14);
    btn_comment.frame = CGRectMake(260, 20, 50, 14);
}

-(void)countBtnClicked{
    [self sendUISignal:MYGirdCell.COUNT];
}

-(void)commentBtnClicked{
    [self sendUISignal:MYGirdCell.COMMENT withObject:self.cellData];
}

@end

@interface ViewController1 (){
    NSArray *datas;
}


@end

@implementation ViewController1

-(void)handleUISignal_MYGirdCell:(BeeUISignal *)signal{
    if ([signal is:MYGirdCell.COUNT]) {
        MYGirdCell *cell = signal.source;
        NSDictionary *dict = (NSDictionary *)cell.cellData;
        CC(@"%@被点击",[dict stringAtPath:@"content"]);
    }else if ([signal is:MYGirdCell.COMMENT]){
        NSDictionary *dict = (NSDictionary *)signal.object;
        CC(@"%@被评论",[dict stringAtPath:@"content"]);
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"测试数据1",@"content",@"20",@"count",@"3",@"comment", nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"测试数据2",@"content",@"30",@"count",@"4",@"comment", nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"测试数据3",@"content",@"10",@"count",@"2",@"comment", nil];
    datas = [[NSArray alloc]initWithObjects:dict1,dict2,dict3, nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return [datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    UITableViewCell *cell = [tableView dequeueReusableCellWithBeeUIGirdCellClass:[MYGirdCell class]];
    cell.gridCell.cellData = [datas objectAtIndex:indexPath.row];
    return cell;
}

@end
