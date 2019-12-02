
//
//  ChatController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/23.
//  Copyright © 2019 张兴栋. All rights reserved.
//
#import "LeftUserCell.h"
#import "RightUserCell.h"
#import "ChatController.h"

@interface ChatController ()  <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,JMessageDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) JMSGConversation * convesation;
@property (nonatomic, strong) NSMutableArray <JMSGMessage *>*jmsgMessageArray;

@end

@implementation ChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf;
    self.title = @"雇主郑婷婷";
    weakSelf.jmsgMessageArray = [NSMutableArray new];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [JMessage removeDelegate:(id<JMessageDelegate>)[UIApplication sharedApplication].delegate withConversation:nil];
    [self registerWithUsernameToJMessage];
}

- (void)dealloc {
    [JMessage removeDelegate:self withConversation:nil];
    [JMessage addDelegate:(id<JMessageDelegate>)[UIApplication sharedApplication].delegate withConversation:nil];
}

#pragma mark ---- registerWithUsernameToJMessage
  
- (void)registerWithUsernameToJMessage {
    WeakSelf;
    [JMSGUser registerWithUsername:@"zhangdongxing_ILV_ZhouXia_" password:@"123456" completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            [weakSelf loginWithUsername];
        } else {
            [weakSelf loginWithUsername];
        }
    }];
}
- (void)loginWithUsername {
    WeakSelf;
    [JMSGUser loginWithUsername:@"zhangdongxing_ILV_ZhouXia_" password:@"123456" completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
        } else {
            NSLog(@" loginWithUsername error is =====-------->>>>>>>>>>>>>%@",error);
        }
    }];
    //创建单聊会话
    [JMSGConversation createSingleConversationWithUsername:@"123456" completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"resultObject is =====-------->>>>>>>>>>>>>%@",resultObject);
               if (!error) {
                  
               } else {
                     NSLog(@" createSingleConversationWithUsername error is =====-------->>>>>>>>>>>>>%@",error);
               }
    }];

    _convesation = [JMSGConversation singleConversationWithUsername:@"123456"];
    [JMessage addDelegate:weakSelf withConversation:weakSelf.convesation];
           #pragma mark  ------------------------ <本地消息记录获取>获取所有消息
           //resultObject 类型为 NSArray，数据成员类型为 JMSGMessage。
    [self getAllMessageWithConvertion:_convesation];
}
// 发送消息
- (void)onSendMessageResponse:(JMSGMessage *)message error:(NSError *)error {
    if (message) {
        _textField.text = @"";
         [_jmsgMessageArray addObject:message];
           [self.tableView reloadData];
           [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.jmsgMessageArray.count -1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}



#pragma mark ------ onReceiveMessage \ onSyncOfflineMessageConversation \ onSyncRoamingMessageConversation ---- 接收消息


//在线消息:逐条下发，每次都触发
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error {
    if (message) {
        [_jmsgMessageArray addObject:message];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.jmsgMessageArray.count -1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
//离线消息:以会话为单位，触发一次下发
- (void)onSyncOfflineMessageConversation:(JMSGConversation *)conversation offlineMessages:(NSArray<__kindof JMSGMessage *> *)offlineMessages {
    [self getAllMessageWithConvertion:conversation];
}
- (void)getAllMessageWithConvertion:(JMSGConversation *)conversation {
    WeakSelf;
    [conversation allMessages:^(NSArray <JMSGMessage *> *jmsgMessageArray, NSError *error) {
        for (NSInteger i = jmsgMessageArray.count - 1; i >=0; i --) {
            JMSGMessage *jmsgMessage = jmsgMessageArray[i];
            if (jmsgMessage && jmsgMessage.contentType == kJMSGContentTypeText) {
               [weakSelf.jmsgMessageArray addObject:jmsgMessage];
            }
        }
        [weakSelf.tableView reloadData];
        if (weakSelf.jmsgMessageArray.count) {
             [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:weakSelf.jmsgMessageArray.count -1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
}
//漫游消息:以会话为单位，触发一次下发
- (void)onSyncRoamingMessageConversation:(JMSGConversation *)conversation {
    [self getAllMessageWithConvertion:conversation];
}


- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat space = KNavigationHeight > 64 ? 70 : 50;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.bounds.size.height - KNavigationHeight - space*ScalePpth) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[LeftUserCell class] forCellReuseIdentifier:@"LeftUserCell"];
        [_tableView registerClass:[RightUserCell class] forCellReuseIdentifier:@"RightUserCell"];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.backgroundColor = RGBHex(0xF7F7F7);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        CGFloat space = KNavigationHeight > 64 ? 70 : 50;
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - space*ScalePpth - KNavigationHeight, ScreenWidth, space*ScalePpth)];
        [self addSubViews];
    }
    return _footerView;
}

- (void)addSubViews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:AutoFrame(12, 15.5, 25, 20)];
    imageView.image = [UIImage imageNamed:@"uploading"];
    [_footerView addSubview:imageView];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(49*ScalePpth, 10.5*ScalePpth, 295*ScalePpth, 30*ScalePpth)];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.font = FontSize(12);
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.placeholder = @"输入消息";
    [_footerView addSubview:_textField];
    
    UIButton *iButton = [[UIButton alloc] initWithFrame:AutoFrame(328, 8.5, 40, 35)];
      [iButton setImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
      [iButton addTarget:self action:@selector(iButtonSend:) forControlEvents:UIControlEventTouchUpInside];
      [_footerView addSubview:iButton];
}
//    [JMSGMessage retractMessage:<#(nonnull JMSGMessage *)#> completionHandler:<#^(id resultObject, NSError *error)handler#>];//撤回消息
- (void)iButtonSend:(UIButton *)button {
    JMSGConversation * convesation = [JMSGConversation singleConversationWithUsername:@"123456"];
    JMSGTextContent  *content = [[JMSGTextContent alloc] initWithText:NoneNull(_textField.text)];
    JMSGMessage * jMmessage = [convesation createMessageWithContent:content];
    [convesation sendMessage:jMmessage];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   [_textField endEditing:YES];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField endEditing:YES];
}

#pragma mark ------ UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _jmsgMessageArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20*ScalePpth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == _jmsgMessageArray.count-1) {
        return 20*ScalePpth;
    }
    return 0.00000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:AutoFrame(0, 0, 0.0000001, 0.0000001)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMSGMessage *jmsgMessage = _jmsgMessageArray[indexPath.section];
    if ([jmsgMessage.fromUser.username  isEqual: @"zhangdongxing_ILV_ZhouXia_"]) {
        RightUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightUserCell" forIndexPath:indexPath];
        cell.content = [jmsgMessage.content valueForKey:@"text"];
        return cell;
    } else {
        LeftUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftUserCell" forIndexPath:indexPath];
         cell.content = [jmsgMessage.content valueForKey:@"text"];
        return cell;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_textField endEditing:YES];
}

@end
