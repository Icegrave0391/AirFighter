//
//  Enemy.h
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Enemy : NSObject
//敌人位置
@property(assign, nonatomic)CGPoint position ;
//敌人生命
@property(assign, nonatomic)NSInteger HP ;
//敌人移动速度
@property(assign, nonatomic)NSInteger speed ;
//击败积分
@property(assign, nonatomic)NSInteger score ;

//敌人状态
@property(assign, nonatomic)BOOL isDead ;
//爆炸帧数是什么
+(Enemy *)enemyWithSize:(CGSize)size andGameArea:(CGRect)gameArea ;

@end
