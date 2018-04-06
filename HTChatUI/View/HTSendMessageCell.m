//
//  HTSendMessageCell.m
//  HTChatUIExample
//
//  Created by coderhong on 2018/4/6.
//  Copyright © 2018年 coderhong. All rights reserved.
//

#import "HTSendMessageCell.h"
#import "Masonry.h"
#import "HTMessage.h"
#import "UIImage+HTExtension.h"

@interface HTSendMessageCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 展示内容button */
@property (weak, nonatomic) IBOutlet UIButton *contentButton;

@end


@implementation HTSendMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentButton.titleLabel.numberOfLines = 0;
    // 设置气泡背景
    [self.contentButton setBackgroundImage:[UIImage stretchableWithImage:[UIImage imageNamed:@"chat_send_nor"]] forState:UIControlStateNormal];
    [self.contentButton setBackgroundImage:[UIImage stretchableWithImage:[UIImage imageNamed:@"chat_send_press_pic"]] forState:UIControlStateHighlighted];
    // 设置按钮内边距
    self.contentButton.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(HTMessage *)message
{
    _message = message;
    if (self.timeLabel.isHidden) {
        self.timeLabel.hidden = YES;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@(0));
        }];
    }else{
        self.timeLabel.hidden = NO;
        self.timeLabel.text = message.time;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@(21));
        }];
    }
    
    [self.contentButton setTitle:message.text forState: UIControlStateNormal];
    // 强制Contentbutton布局
    [self.contentButton layoutIfNeeded];
    
    [self.contentButton mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat titleLabelH = self.contentButton.titleLabel.frame.size.height;
        make.height.mas_equalTo(titleLabelH + 15*2);
    }];
    
    // 强制Cell布局
    [self.contentView layoutIfNeeded];
    
    // 获取cell高度
    CGFloat iconImageViewMaxY = CGRectGetMaxY(self.iconImageView.frame);
    CGFloat contentButtonMaxY = CGRectGetMaxY(self.contentButton.frame);
    
    message.cellHight = MAX(iconImageViewMaxY, contentButtonMaxY) + 10;
    
    
}
@end
