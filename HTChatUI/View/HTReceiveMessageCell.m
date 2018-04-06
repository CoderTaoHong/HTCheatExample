//
//  HTReceiveMessageCell.m
//  HTChatUIExample
//
//  Created by coderhong on 2018/4/6.
//  Copyright © 2018年 coderhong. All rights reserved.
//

#import "HTReceiveMessageCell.h"
#import "HTMessage.h"
#import "Masonry.h"
#import "UIImage+HTExtension.h"

#define kContentButtonEdgeMargin 15

@interface HTReceiveMessageCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 展示内容button */
@property (weak, nonatomic) IBOutlet UIButton *contentButton;

@end

@implementation HTReceiveMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentButton.titleLabel.numberOfLines = 0;
    
    // 设置内容Button的气泡背景
    [self.contentButton setBackgroundImage:[UIImage stretchableWithImage:[UIImage imageNamed:@"chat_recive_nor"]] forState:UIControlStateNormal];
    [self.contentButton setBackgroundImage:[UIImage stretchableWithImage:[UIImage imageNamed:@"chat_recive_press_pic"]] forState:UIControlStateHighlighted];
    
    // 设置内容按钮的内边距
    self.contentButton.contentEdgeInsets = UIEdgeInsetsMake(kContentButtonEdgeMargin, kContentButtonEdgeMargin, kContentButtonEdgeMargin, kContentButtonEdgeMargin);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMessage:(HTMessage *)message
{
    _message = message;
    
    if (message.isHideTime) {
        self.timeLabel.hidden = YES;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(0));
        }];
    }else{
        self.timeLabel.hidden = NO;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(21));
        }];
        self.timeLabel.text = message.time;
    }
    
    [self.contentButton setTitle:message.text forState:UIControlStateNormal];
    
    // 强制刷新
    [self.contentButton layoutIfNeeded];
    
    [self.contentButton mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat titleLabelH = self.contentButton.titleLabel.frame.size.height;
        NSLog(@"-------%f", titleLabelH);
        make.height.equalTo(@(titleLabelH + kContentButtonEdgeMargin*2));
    }];
    
    // 强制刷新
    [self.contentView layoutIfNeeded];
    
    CGFloat contentButtonMaxY = CGRectGetMaxY(self.contentButton.frame);
    CGFloat iconImageViewMaxY = CGRectGetMaxY(self.iconImageView.frame);
    
    message.cellHight = MAX(contentButtonMaxY, iconImageViewMaxY) + 10;
}

@end
