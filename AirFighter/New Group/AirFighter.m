//
//  AirFighter.m
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "AirFighter.h"
#import "Bullet.h"
@implementation AirFighter

+(AirFighter *)airFighterWithSize:(CGSize)size andGameArea:(CGRect)gameArea{
    AirFighter * airFighter = [[AirFighter alloc] init] ;
    CGFloat pos_x = CGRectGetMidX(gameArea) ;
    CGFloat pos_y = CGRectGetMaxY(gameArea) - size.height/2 ;
    airFighter.position = CGPointMake(pos_x, pos_y) ;
    
    airFighter.size = size ;
    airFighter.bombCount = 0 ;
    
    return airFighter ;
}

-(void)shoot{
    CGSize bulletSize ;
    CGFloat bull_x = self.position.x ;
    CGFloat bull_y = self.position.y - self.size.height/2 - bulletSize.height ;
    CGPoint bull_position = CGPointMake(bull_x, bull_y) ;
    
    Bullet * bullet = [Bullet bulletWithPosition:bull_position] ;
    self.bullet = bullet ;
}
//设置我方飞机被撞范围
-(CGRect)hitRect{
    CGFloat x = self.position.x - self.size.width/2 ;
    CGFloat y = self.position.y - self.size.height/2 ;
    CGFloat width = self.size.width ;
    CGFloat height = self.size.height ;
    
    return CGRectMake(x, y, width, height) ;
}

@end
