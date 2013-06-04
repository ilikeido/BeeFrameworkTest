//
//  ViewController.m
//  BeeFrameWorkTest
//
//  Created by he songhang on 13-6-3.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "ViewController.h"

@implementation MyCell

DEF_SIGNAL(COUNT)

DEF_SIGNAL(COMMENT)

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    lb_content = [[UILabel alloc]init];
    btn_count = [[UIButton alloc]init];
    btn_comment = [[UIButton alloc]init];
    
    [btn_count addTarget:self action:@selector(countBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn_comment addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn_count setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn_count.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn_comment setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn_comment.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lb_content];
    [self.contentView addSubview:btn_comment];
    [self.contentView addSubview:btn_count];
    return self;
}

-(void)layoutSubviews{
    lb_content.frame = CGRectMake(10, 0, 300, 44);
    btn_count.frame = CGRectMake(200, 20, 50, 14);
    btn_comment.frame = CGRectMake(260, 20, 50, 14);
}

-(void)setData:(NSDictionary *)data{
    _data = data;
    if (data) {
        lb_content.text = [data stringAtPath:@"content"];
        [btn_count setTitle:[NSString stringWithFormat:@"浏览(%@)",[data stringAtPath:@"count"]] forState:UIControlStateNormal];
        [btn_comment setTitle:[NSString stringWithFormat:@"评论(%@)",[data stringAtPath:@"comment"]] forState:UIControlStateNormal];
    }else{
        lb_content.text = nil;
        [btn_count setTitle:nil forState:UIControlStateNormal];
        [btn_comment setTitle:nil forState:UIControlStateNormal];
    }
}

-(void)countBtnClicked{
    [self sendUISignal:MyCell.COUNT withObject:self.data];
}

-(void)commentBtnClicked{
    [self sendUISignal:MyCell.COMMENT withObject:self.data];
}

@end

@interface ViewController (){
    NSArray *datas;
}

@end

@implementation ViewController

-(void)handleUISignal_MyCell:(BeeUISignal *)signal{
    if ([signal is:MyCell.COUNT]) {
        NSDictionary *dict = (NSDictionary *)signal.object;
        CC(@"%@被点击",[dict stringAtPath:@"content"]);
    }else if ([signal is:MyCell.COMMENT]){
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
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYCELL"];
    if (!cell) {
        cell = [[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MYCELL"];
    }
    cell.data = [datas objectAtIndex:indexPath.row];
    return cell;
}


@end
