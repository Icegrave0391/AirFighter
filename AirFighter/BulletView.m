//
//  BulletView.m
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "BulletView.h"

@implementation BulletView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BulletView *)initWithBulletImage:(UIImage *)image andBullet:(Bullet *)bullet andSize:(CGSize)size{
    UIGraphicsBeginImageContext(size) ;
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)] ;
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext() ;
    UIGraphicsEndImageContext() ;
    self = [super initWithImage:scaledImage] ;
    if(self){
        self.bullet = bullet ;
    }
    return self ;
}

@end
