//
//  NewsViewController.m
//  interestingProject
//
//  Created by mark on 2019/12/27.
//  Copyright © 2019 mark. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import "NewsDetailViewController.h"
@interface NewsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSString *nextPage;
@property(nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"interesting";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    
    [self setTaleView];
    
    __weak typeof(self)weakSelf = self;
    [PubliceObject beginReFreshControl:self.tableView onHeader:^{
        weakSelf.nextPage = nil;
        [weakSelf getData];
    } onFooter:^{
        [weakSelf getData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
       
}

- (void)setTaleView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.rowHeight = 260 * SCREEN_POINT_375;
    [_tableView setTableHeaderView:[UIView new]];
    [_tableView setTableFooterView:[UIView new]];
    [self.view addSubview:_tableView];
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NewsModel *model = self.dataSource[indexPath.row];
    [cell configWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsModel *model = self.dataSource[indexPath.row];
    NSString *decodedURL = [model.actionUrl stringByRemovingPercentEncoding];
    if ([decodedURL containsString:@"url"]) {
        NSArray *array = [decodedURL componentsSeparatedByString:@"url="];
        NSLog(@"%@", array.lastObject);
        model.actionUrl = array.lastObject;
        NewsDetailViewController *newVc = [[NewsDetailViewController alloc]init];
        newVc.selectModel = model;
        newVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newVc animated:YES];
    }
}

#pragma mark- 获取数据
- (void)getData {
    __weak typeof(self)weakSelf = self;
    [Networking requestDailyNewsWithUrl:self.nextPage
                           successBlock:^(NSInteger code, id responseObject) {
        [PubliceObject endRefreshControl:weakSelf.tableView];
        NSString *nextPage = NSStringFromDictionaryForKey(responseObject, @"nextPageUrl");
        weakSelf.nextPage = [NSString stringWithFormat:@"%@&f=iphone&vc=6704", nextPage];
        if (nextPage.length == 0) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tableView reloadData];
        }
        NSArray <NSDictionary *> *soureArr = NSArrayFromDictionaryForKey(responseObject, @"itemList");
        NSMutableArray <NewsModel *> *modelArr = [[NSMutableArray alloc]init];
        for (NSDictionary *tmpDict in soureArr) {
            NSString *type = NSStringFromDictionaryForKey(tmpDict, @"type");
            if ([type isEqualToString:@"informationCard"]) {
                NSDictionary *dataDict = NSDictionaryFromDictionaryForKey(tmpDict, @"data");
                NewsModel *model = [NewsModel mj_objectWithKeyValues:dataDict];
                [modelArr addObject:model];
            }
        }
        [weakSelf.dataSource addObjectsFromArray:modelArr];
        [weakSelf.tableView reloadData];
    } failBlock:^(NSError *error) {
        [PubliceObject endRefreshControl:weakSelf.tableView];
    } isIndicator:YES];
}

@end
