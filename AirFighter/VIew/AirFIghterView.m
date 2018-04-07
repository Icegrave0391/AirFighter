//
//  AirFIghterView.m
//  AirFighter
//
//  Created by 张储祺 on 2018/4/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "AirFIghterView.h"

@implementation AirFIghterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(AirFIghterView *)initWithAirFighterImage:(UIImage *)image {
    CGSize airFighterSize = CGSizeMake(40, 40) ;
    UIGraphicsBeginImageContext(airFighterSize) ;
    [image drawInRect:CGRectMake(0, 0, airFighterSize.width, airFighterSize.height)] ;
    
    UIImage * airFIghterImage = UIGraphicsGetImageFromCurrentImageContext() ;
    UIGraphicsEndImageContext() ;
    self = [super initWithImage:airFIghterImage] ;
    return self ;
}


@end
