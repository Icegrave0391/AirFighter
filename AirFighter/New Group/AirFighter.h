//
//  AirFighter.h
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>

@class Bullet ;

@interface AirFighter : NSObject

@property(assign , nonatomic) CGPoint position ;
@property(assign , nonatomic) CGSize size ;
@property(assign , nonatomic) NSInteger bombCount ;

//碰撞
@property(assign , nonatomic ,readonly) CGRect hitRect ;
//子弹
@property(strong, nonatomic)Bullet * bullet ;

+(AirFighter *)airFighterWithSize:(CGSize)size andGameArea:(CGRect)gameArea ;
//射击
-(void)shoot ;
@end
