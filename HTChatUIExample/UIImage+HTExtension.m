//
//  UIImage+HTExtension.m
//  HTChatUIExample
//
//  Created by coderhong on 2018/4/6.
//  Copyright © 2018年 coderhong. All rights reserved.
//

#import "UIImage+HTExtension.h"

@implementation UIImage (HTExtension)
+ (UIImage *)stretchableWithImage:(UIImage *)image
{
    // 老方法
    // UIImageResizingModeTile 平铺
    // UIImageResizingModeStretch 拉伸
//    [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height, image.size.width, image.size.height-1, image.size.width-1) resizingMode: UIImageResizingModeStretch];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height * 0.5];
}
@end
