//
//  AirGame.h
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Enemy.h"
@class AirFighter ;
@interface AirGame : NSObject
//游戏区域
@property(assign, nonatomic)CGRect gameArea ;
//我方战机
@property(strong, nonatomic)AirFighter * airFighter ;

+(AirGame *)airGameWithGameArea:(CGRect)gameArea andAirFighterSize:(CGSize)size ;
-(Enemy *)enemyWithSize:(CGSize)size ;

@end
