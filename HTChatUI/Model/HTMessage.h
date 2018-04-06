//
//  HTMessage.h
//  HTChatUIExample
//
//  Created by coderhong on 2018/4/6.
//  Copyright © 2018年 coderhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMessage : NSObject
typedef NS_ENUM(NSInteger, HTChatMsgType) {
    HTChatMsgTypeSend = 0,
    HTChatMsgTypeAccept
};

/** 消息 */
@property (nonatomic, strong) NSString *text;
/** 时间 */
@property (nonatomic, strong) NSString *time;
/** 消息类型 */
@property (nonatomic, assign) HTChatMsgType type;
/** 是否隐藏时间Lable */
@property (nonatomic, assign, getter=isHideTime) BOOL hideTime;

/** Cell的高度 */
@property (nonatomic, assign) CGFloat cellHight;

+ (instancetype)messageWithDict: (NSDictionary *)dict;
@end
