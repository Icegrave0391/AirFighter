//
//  BulletView.h
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Bullet ;
@interface BulletView : UIImageView

@property(strong, nonatomic)Bullet * bullet ;

-(BulletView *)initWithBulletImage:(UIImage *)image andBullet:(Bullet *)bullet andSize:(CGSize)size;

@end
