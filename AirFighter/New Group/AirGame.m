//
//  AirGame.m
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "AirGame.h"
#import "AirFighter.h"

@implementation AirGame

+(AirGame *)airGameWithGameArea:(CGRect)gameArea andAirFighterSize:(CGSize)size{
    AirGame * gameModel = [[AirGame alloc] init] ;
    gameModel.gameArea = gameArea ;
    
    gameModel.airFighter = [AirFighter airFighterWithSize:size andGameArea:gameArea] ;
    return gameModel ;
}

-(Enemy *)enemyWithSize:(CGSize)size{
    Enemy * enemy = [Enemy enemyWithSize:size andGameArea:self.gameArea] ;
    return enemy ;
}

@end
