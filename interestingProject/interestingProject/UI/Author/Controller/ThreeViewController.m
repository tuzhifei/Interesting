//
//  ThreeViewController.m
//  App
//
//  Created by Mark on 19/9/5.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import "ThreeViewController.h"
#import "MyHelper.h"
#import "AuthorTableViewCell.h"
#import "AuthorModel.h"
#import "AuthorDetailController.h"

@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *TableView;

@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) NSDictionary *Dict;

@property (nonatomic, strong) NSString *nextPageUrl;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nextPageUrl = [NSString new];
    
    [self setNavi];
    [self setTableView];
    
    __weak typeof(self)weakSelf = self;
    [PubliceObject beginReFreshControl:self.TableView
                              onHeader:^{
        weakSelf.nextPageUrl = nil;
        [weakSelf.modelArr removeAllObjects];
        [weakSelf getNetData];
    } onFooter:^{
        [weakSelf getNetData];
    }];
    
    [self.TableView.mj_header beginRefreshing];
}

- (NSMutableArray *)modelArr {
    if (_modelArr == nil) {
        _modelArr = [[NSMutableArray alloc]init];
    }
    return _modelArr;
}

-(void)setTableView{
    
    _TableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.rowHeight = 70;
    [self.view addSubview:_TableView];
}

-(void)setNavi{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"interesting";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}


- (void)getNetData{
    __weak typeof(self)weakSelf = self;
    [Networking requestAuthorWithUrl:self.nextPageUrl
                        successBlock:^(NSInteger code, id responseObject) {
        NSArray *itemListArr = NSArrayFromDictionaryForKey(responseObject, @"itemList");
        weakSelf.nextPageUrl = NSStringFromDictionaryForKey(responseObject, @"nextPageUrl");
        if (weakSelf.nextPageUrl.length == 0) {
            [weakSelf.TableView.mj_footer endRefreshingWithNoMoreData];
        }
        NSMutableArray <AuthorModel *> *dataArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in itemListArr) {
            NSDictionary *dataDict = dict[@"data"];
            AuthorModel *model = [[AuthorModel alloc]init];
            model.iconImage = NSStringFromDictionaryForKey(dataDict, @"icon");
            model.authorLabel = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
            model.videoCount = [NSString stringWithFormat:@"%@",dataDict[@"subTitle"]];
            model.desLabel = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
            model.authorId = [NSString stringWithFormat:@"%@",dataDict[@"id"]];
            model.actionUrl = [NSString stringWithFormat:@"%@",dataDict[@"actionUrl"]];
            [dataArr addObject:model];
        }
        [weakSelf.modelArr addObjectsFromArray:dataArr];
        [weakSelf.TableView reloadData];
        [PubliceObject endRefreshControl:weakSelf.TableView];
    } failBlock:^(NSError *error) {
        [PubliceObject endRefreshControl:weakSelf.TableView];
    } isIndicator:YES];
}

#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *iDs = @"cell";
    AuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iDs];
    if (!cell) {
        
        cell = [[AuthorTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iDs];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    AuthorModel *model = _modelArr[indexPath.row];
    NSInteger x = model.authorLabel.length;
//    NSInteger y = model.videoCount.length;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.authorLabel]];
    [str setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                         NSForegroundColorAttributeName:[UIFont fontWithName:MyChinFont size:14.f]
    } range:NSMakeRange(0, x)];
    cell.authorLabel.attributedText = str;
    cell.desLabel.text = model.desLabel;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconImage]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthorDetailController *detail = [[AuthorDetailController alloc]init];
    AuthorModel *model = _modelArr[indexPath.row];
    detail.authorId = model.authorId;
    detail.authorIcon = model.iconImage;
    detail.authorDesc = model.desLabel;
    detail.authorName = model.authorLabel;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

/**
 *  这里最主要的代码,通过滑动,改变透明度
 *
 *  @param scrollView scrollView description
 */
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    self.navigationController.navigationBar.alpha = scrollView.contentOffset.y/200;
//}

@end
