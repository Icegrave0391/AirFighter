//
//  Enemy.m
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

+(Enemy *)enemyWithSize:(CGSize)size andGameArea:(CGRect)gameArea{
    Enemy * enemy = [[Enemy alloc] init] ;
    CGFloat pos_x = arc4random_uniform(gameArea.size.width-size.width)+size.width/2 ;
    CGFloat pos_y = -size.height/2 ;
    enemy.HP = 2 ;
    enemy.speed = arc4random_uniform(8)+2 ;
    enemy.score = 1000 ;
    enemy.position = CGPointMake(pos_x, pos_y) ;
    enemy.isDead = NO ;

    return enemy ;
}

@end
