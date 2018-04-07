//
//  EnemyView.m
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "EnemyView.h"
#import "Enemy.h"
@implementation EnemyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(EnemyView *)initWithEnemy:(Enemy *)enemy{
    self = [super init] ;
    UIImage * image = [UIImage imageNamed:@"enemyAirCraft"] ;
    CGSize enemySize = CGSizeMake(40, 40) ;
    UIGraphicsBeginImageContext(enemySize) ;
    [image drawInRect:CGRectMake(0, 0, enemySize.width, enemySize.height) ] ;
    UIImage * enemyImage = UIGraphicsGetImageFromCurrentImageContext() ;
    UIGraphicsEndImageContext() ;
    if(self){
        self.enemy = enemy ;
        self.image = enemyImage ;
        self.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height) ;
        self.center = self.enemy.position;
    }
    return self ;
}

@end
