//
//  LRefreshTestViewController.m
//  CSCUtil
//
//  Created by csc on 16/10/11.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "LRefreshTestViewController.h"
#import "LRefreshNormalHeader.h"
#import "LRefreshNormalFooter.h"
@interface LRefreshTestViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView * prTable;

@property (strong, nonatomic) NSMutableArray * dataArray;
@end

@implementation LRefreshTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _dataArray = [[NSMutableArray alloc]initWithCapacity:1];
    [self fakeData];
    [self createTable];
    
}

-(void)fakeData
{
    for(NSInteger i = 0; i<6; i++)
    {
        [_dataArray addObject:[NSString stringWithFormat:@"嘿嘿-%tu",i]];
    }
}

-(void)createTable
{
    self.prTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CSWIDTH, CSHEIGHT) style:UITableViewStylePlain];
    self.prTable.delegate = self;
    self.prTable.dataSource = self;
    self.prTable.tableFooterView = [UIView new];
    [self.view addSubview:self.prTable];
    
    
    //下拉刷新
    self.prTable.l_header = [LRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
        
    }];
    
    
    //上拉加载
    self.prTable.l_footer = [LRefreshNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            
            for(NSInteger i = 6;i<17;i++)
            {
                [_dataArray addObject:[NSString stringWithFormat:@"嘿嘿-%tu",i]];
            }
            
            //[self.prTable.l_footer endRefreshing];
            
            [self.prTable reloadData];
            
            
            [self.prTable.l_footer endRefreshingWithNoMoreData];
            
        });
    }];
    
    
    
//
//    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//    [self.prTable addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
//    [self.prTable addObserver:self forKeyPath:@"contentSize" options:options context:nil];
//    
    
    
//    UIView * sview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CSWIDTH, 54)];
//    sview.backgroundColor = [UIColor redColor];
//    [self.prTable insertSubview:sview atIndex:0];
    
    
    
}

-(void)refreshData
{
    [_dataArray removeAllObjects];
    [self.prTable reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fakeData];
        // 结束刷新
        [self.prTable.l_header endRefreshing];
        [self.prTable reloadData];
        [self.prTable.l_footer resetNoMoreData];
    });
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        //[self scrollViewContentOffsetDidChange:change];
       NSLog(@"final--------->>>%f",self.prTable.contentOffset.y);
    }else if ([keyPath isEqualToString:@"contentSize"]) {
        NSLog(@"sizefinal--------->>>%f",self.prTable.contentSize.height-self.prTable.bounds.size.height);;
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellinfo = @"cellinfo";
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:cellinfo];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellinfo];
    }
    NSLog(@"----------------%tu",indexPath.row);
    cell.textLabel.text = [NSString stringWithFormat:@"大王大   %tu",_dataArray[indexPath.row]];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
