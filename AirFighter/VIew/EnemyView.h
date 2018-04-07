//
//  EnemyView.h
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Enemy ;
@interface EnemyView : UIImageView

@property(strong, nonatomic)Enemy * enemy ;

-(EnemyView *)initWithEnemy:(Enemy *) enemy ;

@end
