//
//  HTMessage.m
//  HTChatUIExample
//
//  Created by coderhong on 2018/4/6.
//  Copyright © 2018年 coderhong. All rights reserved.
//

#import "HTMessage.h"

@implementation HTMessage

+ (instancetype)messageWithDict: (NSDictionary *)dict
{
    HTMessage *message = [[self alloc] init];
    [message setValuesForKeysWithDictionary: dict];
    return message;
}
@end
