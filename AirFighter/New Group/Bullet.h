//
//  Bullet.h
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Bullet : NSObject
//子弹位置
@property(assign, nonatomic) CGPoint position ;
//子弹伤害
@property(assign, nonatomic) NSInteger damage ;

+(Bullet *)bulletWithPosition:(CGPoint)pos ;
@end
