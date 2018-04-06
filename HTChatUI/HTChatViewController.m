//
//  HTChatViewController.m
//  HTChatUIExample
//
//  Created by coderhong on 2018/4/6.
//  Copyright © 2018年 coderhong. All rights reserved.
//

#import "HTChatViewController.h"
#import "HTMessage.h"
#import "HTSendMessageCell.h"
#import "HTReceiveMessageCell.h"

@interface HTChatViewController ()<UITableViewDataSource, UITableViewDelegate>
/** 底部工具条距离控制器View的距离 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
/** 所有的消息模型 */
@property (nonatomic, strong) NSArray *messages;

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;

/**底部工具条距离view底部的约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonViewMargin;

@end

static NSString *const sendMessageCellID = @"sendMessage";
static NSString *const receiveMessageCellID = @"receiveMessage";
@implementation HTChatViewController
- (NSArray *)messages
{
    if (!_messages) {
        // 加载pist中的消息数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray* dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 记录上一条消息模型
        HTMessage *lastMessage =nil;
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HTMessage *msg = [HTMessage messageWithDict:dict];
            // 判断timeLabel是否隐藏
            msg.hideTime = [msg.time isEqualToString:lastMessage.time];
            [tempArr addObject:msg];
            
            // 保存当前message
            lastMessage = msg;
        }
        _messages = tempArr;
    }
    return _messages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatTableView.contentInset = UIEdgeInsetsMake(HT_StatusBarAndNavigationBarHeight, 0, 0, 0);
    
    // 处理底部输入工具条距离底部的间距
    if (@available(iOS 11, *)) {
        self.bottomMargin.constant = HT_TabbarSafeBottomMargin;
        
        self.chatTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 处理输入框光标做间距
    UIView *placeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
    self.inputField.leftView = placeView;
    self.inputField.leftViewMode = UITextFieldViewModeWhileEditing;
    
    // 注册cell
    [self.chatTableView registerNib:[UINib nibWithNibName:@"HTSendMessageCell" bundle:nil] forCellReuseIdentifier:sendMessageCellID];
    [self.chatTableView registerNib:[UINib nibWithNibName:@"HTReceiveMessageCell" bundle:nil] forCellReuseIdentifier:receiveMessageCellID];
    
    // 键盘即将显示
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 这个监听也可以 可以代替UIKeyboardWillShowNotification UIKeyboardWillHideNotification两个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 {
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 333}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 978.5}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 645.5}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 812}, {375, 333}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 479}, {375, 333}}";
 UIKeyboardIsLocalUserInfoKey = 1;
 }
 
 */
//- (void)keyboardWillShow:(NSNotification *)noti
//{
//    // 键盘最终弹出后的fame
//    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    self.bottomConstant.constant = rect.size.height;
//    // 键盘弹出所需时间
//     CGFloat animation = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    [UIView animateWithDuration:animation animations:^{
//        [self.view layoutIfNeeded];
//    }];
//}

/**
 {
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 333}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 645.5}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 978.5}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 479}, {375, 333}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 812}, {375, 333}}";
 UIKeyboardIsLocalUserInfoKey = 1;
 }
 */
//- (void)keyboardWillHide:(NSNotification *)noti
//{
//    self.bottomConstant.constant = 0;
//    // 键盘弹出所需时间
//    CGFloat animation = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    [UIView animateWithDuration:animation animations:^{
//        [self.view layoutIfNeeded];
//    }];
//}

/**
 显示
 {
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 333}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 978.5}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 645.5}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 812}, {375, 333}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 479}, {375, 333}}";
 UIKeyboardIsLocalUserInfoKey = 1;
 
 隐藏
 2018-04-06 15:42:26.135452+0800 HTChatUIExample[25894:3333935] -{
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 333}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 645.5}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 978.5}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 479}, {375, 333}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 812}, {375, 333}}";
 UIKeyboardIsLocalUserInfoKey = 1;
 }
 }
 
 */
- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    NSLog(@"-%@", noti.userInfo);
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottonViewMargin.constant = [UIScreen mainScreen].bounds.size.height - rect.origin.y + HT_TabbarSafeBottomMargin;
    // 键盘弹出所需时间
    CGFloat animation = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animation animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTMessage *msg = self.messages[indexPath.row];
    if (msg.type == HTChatMsgTypeSend) { // 发送
       HTSendMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:sendMessageCellID forIndexPath:indexPath];
        cell.message = msg;
        return cell;
    }else{ // 接受
       HTReceiveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:receiveMessageCellID forIndexPath:indexPath];
        cell.message = msg;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTMessage *msg = self.messages[indexPath.row];
    return msg.cellHight;
}

// 一般聊天软件拖动tableView隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 键盘消失
    [self.view endEditing:YES];
}

-(void)dealloc
{
    // 移除通知（必须）
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
