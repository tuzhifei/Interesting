//
//  OneViewController.m
//  App
//
//  Created by Mark on 19/9/5.
//  Copyright © 2019年 Mark. All rights reserved.
//
// 
// 


#import "OneViewController.h"
#import "VideoListTableViewCell.h"
#import "DailyDetailViewController.h"
#import "VideoListModel.h"

@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
// 网络请求
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@property (nonatomic, strong) NSMutableArray *ListArr;

@property (nonatomic, strong) NSString *NextPageStr;

@end

@implementation OneViewController

- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"interesting";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    // 设置TableView
    [self setTableView];
    // 获取网络数据
//    [self getNetData];
    
   
    
    
    [PubliceObject beginReFreshControl:self.tableView onHeader:^{
        [self getNetDataWithUrl:nil];
    } onFooter:^{
        [self getNetDataWithUrl:self.NextPageStr];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

// 设置TableView
-(void)setTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = 260 * SCREEN_POINT_375;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = COLOR_Line;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.view addSubview:self.tableView];
}

// 获取数据
-(void)getNetDataWithUrl:(NSString *)urlString{
    __weak typeof(self)weakSelf = self;
    if (urlString.length == 0) {
        self.ListArr = [[NSMutableArray alloc]init];
    }
    [SMProgressHUD showWithStatus:@"数据加载中..."];
    [Networking requestDailyVideoWithUrl:urlString successBlock:^(NSInteger code, id responseObject) {
        [SMProgressHUD hideIndicator];
        self.NextPageStr = NSStringFromDictionaryForKey(responseObject, @"nextPageUrl");
        NSArray *dataArr = NSArrayFromDictionaryForKey(responseObject, @"itemList");
        for (NSDictionary *tmpDict in dataArr) {
            NSString *dataType = NSStringFromDictionaryForKey(tmpDict, @"data.content.data.dataType");
            if ([dataType isEqualToString:@"VideoBeanForClient"]) {
                NSDictionary *contenDict = NSDictionaryFromDictionaryForKey(tmpDict, @"data.content.data");
                VideoListModel *model = [[VideoListModel alloc]init];
                model.titleLabel = NSStringFromDictionaryForKey(contenDict, @"title");
                model.desc = NSStringFromDictionaryForKey(contenDict, @"description");
                model.playUrl = NSStringFromDictionaryForKey(contenDict, @"playUrl");
                model.consumption = NSDictionaryFromDictionaryForKey(contenDict, @"consumption");
                model.ImageView = NSStringFromDictionaryForKey(contenDict, @"cover.feed");
                model.duration = NSStringFromDictionaryForKey(contenDict, @"duration");
                model.category = NSStringFromDictionaryForKey(contenDict, @"category");
                model.authorIcon = NSStringFromDictionaryForKey(contenDict, @"author.icon");
                model.authorName = NSStringFromDictionaryForKey(contenDict, @"author.name");
                [weakSelf.ListArr addObject:model];
            }
            [weakSelf.tableView reloadData];
            [PubliceObject endRefreshControl:weakSelf.tableView];
        }
    } failBlock:^(NSError *error) {
        [PubliceObject endRefreshControl:weakSelf.tableView];
    } isIndicator:YES];
}

#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[VideoListTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    VideoListModel *model = self.ListArr[indexPath.row];
    [cell configWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DailyDetailViewController *detail = [[DailyDetailViewController alloc]init];
    detail.model = self.ListArr[indexPath.row];
    detail.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:detail animated:YES completion:nil];
}


//转换时间格式
-(NSString *)timeStrFormTime:(NSString *)timeStr
{
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
}


@end
