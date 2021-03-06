
//
//  HomeController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/12.
//  Copyright © 2019 张兴栋. All rights reserved.

#import "RemingView.h"
#import "YTSegmentBar.h"
#import "PageListModel.h"
#import "HomeTableCell.h"
#import "HomeListModel.h"
#import "UIView+YTSegmentBar.h"
#import "CategoryLabel.h"
#import "HomeController.h"
#import "ZLImageViewDisplayView.h"
#import "GrabdDetailsController.h"
#import "EmployerCenterController.h"
#import "PublishContentController.h"

@interface HomeController () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,YTSegmentBarDelegate,JMessageDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) YTSegmentBar *segmentBar;
@property (nonatomic, strong) RemingView *remindView;
@property (nonatomic, strong) NSArray <HomeListModel*>*listModelArray;
@property (nonatomic, strong) ZLImageViewDisplayView *headerImageView;

@property (nonatomic, assign) NSInteger toIndex;
@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) PageListModel*pageListModel;
@property (nonatomic, assign) BOOL isNoMoreData;

@end

@implementation HomeController


- (YTSegmentBar *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [YTSegmentBar segmentBarWithFrame:CGRectMake(0, 0, 0, 0)];
        _segmentBar.clipsToBounds = YES;
        _segmentBar.delegate = self;
        _segmentBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_segmentBar];
    }
    return _segmentBar;
}
- (ZLImageViewDisplayView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [ZLImageViewDisplayView zlImageViewDisplayViewWithFrame:AutoFrame(0, 92, 355, 136)];
        _headerImageView.imageViewArray = @[@"home_banner",@"home_banner2"];
        _headerImageView.scrollInterval = 3;
        _headerImageView.animationInterVale = 0.6;
        _headerImageView.clipsToBounds = YES;
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.cornerRadius = 5;
        [_headerImageView addTapEventForImageWithBlock:^(NSInteger imageIndex) {
            
        }];
    }
    return _headerImageView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = self.view.frame.size.height - KTabBarHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10*ScalePpth, 0, 355*ScalePpth, height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[HomeTableCell class] forCellReuseIdentifier:@"HomeTableCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGBHex(0xf0f0f0);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.00001, 0.000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        WeakSelf;
        [_tableView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
            weakSelf.pageIndex = pageIndex;
            [ZXD_NetWorking postWithUrl:[rootUrl  stringByAppendingString:@"/ReleaseWork/select/workListHoem"] params:@{
                   @"page":@"1",
                   @"pageSize":@"10",
                   @"workTypeId":@(weakSelf.toIndex),
               } success:^(id  _Nonnull response) {
                weakSelf.pageListModel = [PageListModel mj_objectWithKeyValues:response[@"data"]];
                 GlobalSingleton.gS_ShareInstance.pageListModel = weakSelf.pageListModel;
                [weakSelf.tableView reloadData];
               } fail:^(NSError * _Nonnull error) {
                   
               } showHUD:YES];
        }];
        [_tableView addFooterWithWithHeaderWithAutomaticallyRefresh:YES loadMoreBlock:^(NSInteger pageIndex) {
            weakSelf.pageIndex = pageIndex;
            [ZXD_NetWorking postWithUrl:[rootUrl  stringByAppendingString:@"/ReleaseWork/select/workListHoem"] params:@{
                   @"page":@(pageIndex),
                   @"pageSize":@"10",
                   @"workTypeId":@(weakSelf.toIndex),
               } success:^(id  _Nonnull response) {
                if (response) {
                    if ([response[@"data"][@"pageNum"] isEqual:response[@"data"][@"pages"]]) {
                        [weakSelf.tableView endFooterNoMoreData];
                    }
                }
                [weakSelf.tableView endFooterRefresh];
                if (weakSelf.pageIndex <= [response[@"data"][@"pages"] integerValue] && weakSelf.pageIndex > 1) {
                    
                    NSMutableArray *listArray = weakSelf.pageListModel.list.mutableCopy ?:[NSMutableArray new];
                        weakSelf.pageListModel = [PageListModel mj_objectWithKeyValues:response[@"data"]];
                    [weakSelf.pageListModel.list enumerateObjectsUsingBlock:^(PageContentListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [listArray addObject:obj];
                    }];
                    weakSelf.pageListModel.list = listArray;
                     GlobalSingleton.gS_ShareInstance.pageListModel = weakSelf.pageListModel;
                    [weakSelf.tableView reloadData];
                }
               } fail:^(NSError * _Nonnull error) {

               } showHUD:YES];
        }];
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 355, 278)];
        UIButton *addressButton =  [[UIButton alloc] initWithFrame:CGRectMake(15*ScalePpth,  15*ScalePpth, 60*ScalePpth, 18.1*ScalePpth)];
        [addressButton setTitle:@"济南" forState:UIControlStateNormal];
        [addressButton setImage:[UIImage imageNamed:@"home_arrow_bottom"] forState:UIControlStateNormal];
        [addressButton setImageEdgeInsets:UIEdgeInsetsMake(0, 43*ScalePpth, 0, 0)];
        [addressButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20*ScalePpth, 0,13*ScalePpth)];
        addressButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [addressButton setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
        [_headerView addSubview:addressButton];
        UIButton *addButton =  [[UIButton alloc] initWithFrame:CGRectMake(324*ScalePpth, 15*ScalePpth, 16*ScalePpth, 16*ScalePpth)];
        [addButton setImage:[UIImage imageNamed:@"home_plus"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:addButton];
        [_headerView addSubview:self.searchBar];
        [_headerView addSubview:self.headerImageView];
        [self addsegmentBar];
    }
    return _headerView;
}
- (void)addsegmentBar {
    [_headerView addSubview:self.segmentBar];
    self.segmentBar.frame = AutoFrame(0, 228, 355, 50);
    self.segmentBar.showIndicator = YES;
    self.segmentBar.backgroundColor = [UIColor clearColor];
}
#pragma mark - YTSegmentBarDelegate
- (void)segmentBar:(YTSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    _toIndex = toIndex;
    if (toIndex == 0) {
        _toIndex = -1;
    } else if (toIndex == 1) {
        _toIndex = -2;
    } else {
        _toIndex = [[_listModelArray[toIndex-2] idName] NonNull integerValue];
    }
    WeakSelf;
    [ZXD_NetWorking postWithUrl:[rootUrl  stringByAppendingString:@"/ReleaseWork/select/workListHoem"] params:@{
                      @"page":@(1),
                      @"pageSize":@"10",
                      @"workTypeId":@((weakSelf.toIndex)),
                  } success:^(id  _Nonnull response) {
                     weakSelf.pageListModel = [PageListModel mj_objectWithKeyValues:response[@"data"]];
                    [weakSelf.tableView reloadData];
                  } fail:^(NSError * _Nonnull error) {
                  } showHUD:YES];
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:AutoFrame(0, 44, 355, 38)];
        _searchBar.placeholder = @"输入您要搜索的内容";
        _searchBar.barStyle = UISearchBarStyleMinimal;
        _searchBar.delegate = self;
        UIImage * searchBarBg = [self GetImageWithColor:[UIColor whiteColor] andHeight:38.0 *ScalePpth];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:[UIColor whiteColor]];
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        //更改输入框圆角
        _searchBar.layer.cornerRadius = 19.0f*ScalePpth;
        _searchBar.layer.masksToBounds = YES;
        //更改输入框字号
        UITextField  *seachTextFild = (UITextField*)[self subViewOfClassName:@"UISearchBarTextField" view:_searchBar];
        seachTextFild.font = [UIFont systemFontOfSize:12 *ScalePpth];
    }
    return _searchBar;
}
- (UIView*)subViewOfClassName:(NSString*)className view:(UIView *)view{
    for (UIView* subView in view.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        UIView* resultFound = [self subViewOfClassName:className view:subView];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}
/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    WeakSelf;
       [ZXD_NetWorking getWithUrl:[rootUrl stringByAppendingString:@"/ReleaseWork/WorkSort1"] params:@{} success:^(id  _Nonnull response) {
           if (response && response[@"data"]) {
               weakSelf.listModelArray = [HomeListModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
               [weakSelf addsegerbar];
               [[NSUserDefaults standardUserDefaults] setObject:response[@"data"] forKey:@"HomeListModelArray"];
           }
       } fail:^(NSError * _Nonnull error) {

       } showHUD:NO];
       [ZXD_NetWorking postWithUrl:[rootUrl  stringByAppendingString:@"/ReleaseWork/select/workListHoem"] params:@{
           @"page":@"1",
           @"pageSize":@"10",
           @"workTypeId":@"-1",
       } success:^(id  _Nonnull response) {
           weakSelf.pageListModel = [PageListModel mj_objectWithKeyValues:response[@"data"]];
           GlobalSingleton.gS_ShareInstance.pageListModel = weakSelf.pageListModel;
           [weakSelf.tableView reloadData];
       } fail:^(NSError * _Nonnull error) {

       } showHUD:YES];
}

#pragma mark ----- viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    _toIndex = -1;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = RGBHex(0xf0f0f0);
    GlobalSingleton.gS_ShareInstance.contentType = @"abc";
    [self.view addSubview:self.tableView];

}
- (void)addsegerbar {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray: @[@"今日推荐",@"抢单中心"]];
    [_listModelArray enumerateObjectsUsingBlock:^(HomeListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mutableArray addObject:obj.typeWork];
    }];
    self.segmentBar.items = mutableArray;
    self.segmentBar.selectIndex = 0;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark ---- addbutton

- (void)addAction:(UIButton *)button {
    if (!_remindView) {
        _remindView = [[RemingView alloc] init];
        WeakSelf;
        [_remindView setBlock:^(NSInteger index) {
             [weakSelf.remindView removeFromSuperview];
            if (index == 2) {               
                [weakSelf presentViewController:[PublishContentController new] animated:YES completion:nil];
            } else if (index == 3) {
                 [weakSelf.navigationController pushViewController:[EmployerCenterController new] animated:YES];
            }
        }];
    }
    [GlobalSingleton.gS_ShareInstance.systemWindow addSubview:self.remindView];
}

#pragma mark ------ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _pageListModel.list.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 117*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableCell" forIndexPath:indexPath];
    WeakSelf;
    cell.listModel = _pageListModel.list[indexPath.section];
    cell.detailBlock = ^(PageContentListModel * model) {
        GrabdDetailsController *gdc = [GrabdDetailsController new];
        gdc.listModel = model;
        [weakSelf.navigationController pushViewController:gdc animated:NO];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PageContentListModel * model = _pageListModel.list[indexPath.section];
    GrabdDetailsController *gdc = [GrabdDetailsController new];
    gdc.listModel = model;
    [self.navigationController pushViewController:gdc animated:NO];
}
@end
