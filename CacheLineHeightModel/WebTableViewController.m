//
//  WebTableViewController.m
//  CacheLineHeightModel
//
//  Created by qingweiqw on 16/12/21.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "WebTableViewController.h"
#import "WebModel.h"
#import "CalculateCacheHeight.h"
#import "WebTableViewCell.h"
#import "UIView+Extension.h"

@interface WebTableViewController ()
{
    
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) CalculateCacheHeight *CCH;
@end
static NSString *const ident = @"WebTableViewCell";
@implementation WebTableViewController

- (CalculateCacheHeight *)CCH
{
    if(!_CCH)
    {
        _CCH = [[CalculateCacheHeight alloc] init];
    }
    return _CCH;
}
- (NSMutableArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"缓存行高";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]}];
    [self initUI];
    [self loadData];
}
- (void)initUI {
    
    [self.tableView registerClass:[WebTableViewCell class] forCellReuseIdentifier:ident];
    
}
- (void)loadData {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"statuses" ofType:@"plist"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //主要是为了 缓存cell的高度 数据转模型不要在意
            NSUInteger count = tempArray.count;
            //数据转模型
            for(int i=0;i<count;i++)
            {
                WebModel *model = [[WebModel alloc] initWithDict:tempArray[i]];
                [self.dataArray addObject:model];
            }
            
            [self.tableView reloadData];
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WebTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.frameDic = [self.CCH frameDic:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor cyanColor];
    return cell;
}
//提供行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return [self.CCH heigth:self.dataArray[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%.2f",cell.frame.size.height);
       
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
