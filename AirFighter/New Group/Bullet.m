//
//  Bullet.m
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "Bullet.h"
#define BULLET_DAMAGE 1
@implementation Bullet

+(Bullet *)bulletWithPosition:(CGPoint)pos{
    Bullet * bullet = [[Bullet alloc] init] ;
    bullet.position = pos ;
    bullet.damage = BULLET_DAMAGE ;
    
    return bullet ;
}
@end
