//
//  GameViewController.m
//  AirFighter
//
//  Created by LAgagggggg on 21/03/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//

#import "GameViewController.h"
#import "AirGame.h"
#import "AirFighter.h"
#import "Bullet.h"
#import "Enemy.h"
#import "AirFIghterView.h"
#import "BulletView.h"
#import "EnemyView.h"
#import <QuartzCore/QuartzCore.h>

@interface GameViewController () <UIAlertViewDelegate>
//模型类

@property(strong, nonatomic)AirGame * gameModel ;
//视图
@property(strong, nonatomic)UIView *gameView ;
//控制视图(将控件与游戏视视图分离管理)
@property(strong, nonatomic)UIView *controlView ;
//计时器
@property(strong, nonatomic)CADisplayLink *timer ;
//我方飞机视图化
@property(strong, nonatomic)AirFIghterView * airFighterView ;
//我的子弹视图集合
@property(strong, nonatomic)NSMutableSet * bulletViewSet ;
//敌机视图集合
@property(strong, nonatomic)NSMutableSet * enemyViewSet ;
//得分
@property(assign, nonatomic)NSInteger score ;
//面板
@property(weak, nonatomic)UILabel * scoreLabel ;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.enemyViewSet = [NSMutableSet set] ;
    self.bulletViewSet = [NSMutableSet set] ;
    //时间设定
    
    //游戏视图设定
    UIView * gameView = [[UIView alloc] initWithFrame:self.view.bounds] ;
    gameView.backgroundColor = [UIColor whiteColor] ;
    [self.view addSubview:gameView] ;
    self.gameView = gameView ;
    
    //初始化控制视图
    UIView * controlVIew = [[UIView alloc] initWithFrame:self.view.bounds] ;
    controlVIew.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:controlVIew] ;
    self.controlView = controlVIew ;

    //模型设定
    [self setWholeGameModel] ;
    
    //分数面板
    UILabel * scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 20) ] ;
    scoreLabel.adjustsFontSizeToFitWidth = NO ;
    scoreLabel.textColor = [UIColor blackColor] ;
    scoreLabel.backgroundColor = [UIColor clearColor] ;
    //开始游戏
    [self startTimer] ;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES] ;
    
    self.enemyViewSet = [NSMutableSet set] ;
    self.bulletViewSet = [NSMutableSet set] ;
    //时间设定
    
    //游戏视图设定
    UIView * gameView = [[UIView alloc] initWithFrame:self.view.bounds] ;
    [self.view addSubview:gameView] ;
    self.gameView = gameView ;
    //初始化控制视图
    UIView * controlVIew = [[UIView alloc] initWithFrame:self.view.bounds] ;
    controlVIew.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:controlVIew] ;
    self.controlView = controlVIew ;
    
    //模型设定
    
    //分数面板
    UILabel * scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 20) ] ;
    scoreLabel.adjustsFontSizeToFitWidth = NO ;
    scoreLabel.textColor = [UIColor blackColor] ;
    scoreLabel.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:scoreLabel] ;
}

-(void)setWholeGameModel{
    //初始化游戏模型
    if(!self.gameModel){
        self.gameModel = [AirGame airGameWithGameArea:self.gameView.bounds andAirFighterSize:[UIImage imageNamed:@"airFighter"].size] ;
        //初始化我方飞机视图
        if(!self.airFighterView){
            AirFIghterView * airFighterView = [[AirFIghterView alloc] initWithAirFighterImage:[UIImage imageNamed:@"airFighter"]] ;
            airFighterView.center = self.gameModel.airFighter.position ;
            self.airFighterView = airFighterView ;
            [self.gameView addSubview:airFighterView] ;
        }
    }
}
//计时器开始
-(void)startTimer{
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateUI)] ;
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode] ;
}

//更新label
-(void)updateScoreLabel{
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)self.score] ;
}
#pragma mark updateUI核心
static long long _time ;

-(void)updateUI{
    _time ++ ;
    /*
     if(_UI % 60 == 0 )[self updateTimeClock] ;
    */
    //刷新飞机位置
    self.airFighterView.center = self.gameModel.airFighter.position ;
    //设置虚区频率(一秒5次郎）
    if(_time%12 == 0 )[self.gameModel.airFighter shoot] ;
    [self dealBullet] ;
    //****处理敌人飞机开始
    [self dealEnemy] ;
    [self updateEnemyUI] ;
    //****处理敌人飞机结束
    
    //打击 (子弹&敌人)or(敌人&自己)
    [self hit] ;
    
}

#define BULLET_MOVE_SPEED 5
-(void)dealBullet{
    //配置子弹
    if(self.gameModel.airFighter.bullet){
        BulletView *bulletView = [[BulletView alloc] initWithBulletImage:[UIImage imageNamed:@"bullet"] andBullet:self.gameModel.airFighter.bullet andSize:CGSizeMake(10, 10)] ;
        bulletView.center = self.gameModel.airFighter.bullet.position ;
        [self.gameView addSubview:bulletView] ;
        [self.bulletViewSet addObject:bulletView] ;
        //***立即将该子弹清除
        self.gameModel.airFighter.bullet = nil ;
    }
    //移除集合
    NSMutableSet *needRemove = [NSMutableSet set] ;
    //移动子弹&判断子弹失效(视图
    for(BulletView * bulletView in self.bulletViewSet){
        bulletView.center = CGPointMake(bulletView.center.x, bulletView.center.y-BULLET_MOVE_SPEED) ;
        if(CGRectGetMaxY(bulletView.frame)<=0){
            [needRemove addObject:bulletView] ;
        }
    }
    //移除失效子弹(视图
    for (BulletView * bulletView in needRemove){
        [self.bulletViewSet removeObject:bulletView] ;
        [needRemove removeObject:bulletView] ;
        [bulletView removeFromSuperview] ;
    }
}

//****处理敌人飞机开始****
-(void)dealEnemy{
    Enemy * enemy = nil ;
    //每0.2 - 1.0 s 刷新一架敌人飞机
    int refresh_point = arc4random()%49+12 ;
    if(_time % refresh_point == 0){
        enemy = [self.gameModel enemyWithSize:[UIImage imageNamed:@"enemyAirCraft"].size] ;
        [self configureEnemy:enemy] ;
    }
}

-(void)configureEnemy:(Enemy *)enemy{
    EnemyView * enemyView = [[EnemyView alloc] initWithEnemy:enemy] ;
    [self.gameView addSubview:enemyView] ;
    [self.enemyViewSet addObject:enemyView] ;
}

-(void)updateEnemyUI{
    NSMutableSet * shouldRemove = [NSMutableSet set] ;
    //移动敌人&判断敌人飞机是否超过视图边界
    for(EnemyView * enemyView in self.enemyViewSet){
        Enemy * enemy = enemyView.enemy ;
        enemy.position = CGPointMake(enemy.position.x, enemy.position.y+enemy.speed) ;
        enemyView.center = enemy.position ;
        if(CGRectGetMinY(enemyView.frame)>=self.view.bounds.size.height){
            [shouldRemove addObject:enemyView] ;
        }
    }
    //移除失效敌人
    for(EnemyView * enemyView in shouldRemove){
        [self.enemyViewSet removeObject:enemyView] ;
        [shouldRemove removeObject:enemyView] ;
        [enemyView removeFromSuperview] ;
    }
}
//****处理敌人飞机结束****

//打击处理
-(void)hit{
    //乌鸦坐飞机
    NSMutableSet * shouleRemoveBulletView = [NSMutableSet set] ;
    for(BulletView * bulletView in self.bulletViewSet){
        Bullet * bullet = bulletView.bullet ;
        for(EnemyView * enemtView in self.enemyViewSet){
            Enemy * enemy = enemtView.enemy ;
            //判断是否打击
            if(CGRectIntersectsRect(bulletView.frame, enemtView.frame) && !enemy.isDead){
                enemy.HP -= bullet.damage ;
                if(enemy.HP <= 0){
                    enemy.isDead = YES ;
                }
                [shouleRemoveBulletView addObject:bulletView] ;
                
            }
        }
    }
    for(BulletView * bulletView in shouleRemoveBulletView){
        [bulletView removeFromSuperview] ;
        [self.bulletViewSet removeObject:bulletView] ;
    }
    
    //处理死亡敌机
    NSMutableSet * shouldRemoveEnemyView = [NSMutableSet set] ;
    for(EnemyView * enemyView in self.enemyViewSet){
        Enemy * enemy = enemyView.enemy ;
        if(enemy.isDead){
            enemy.speed = 0 ;
            [shouldRemoveEnemyView addObject:enemyView] ;
        }
    }
    for(EnemyView * enemyView in shouldRemoveEnemyView){
        [self.enemyViewSet removeObject:enemyView] ;
        [enemyView removeFromSuperview] ;
        
        self.score += enemyView.enemy.score ;
        [self updateScoreLabel] ;
    }
    [shouldRemoveEnemyView removeAllObjects] ;
    
    //我方飞机被对面撞了，无法治疗！
    for(EnemyView * enemyView in self.enemyViewSet){
        if(CGRectIntersectsRect(enemyView.frame, self.gameModel.airFighter.hitRect)){
            
          //  [self gameOver] ;
        }
    }
}
//游戏结束
/*
-(void) gameOver{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"游戏结束"
                                                    message:[NSString stringWithFormat:@"您的得分是%ld\n,点击按钮回到主菜单",(long)self.score]
                                                   delegate:self
                                          cancelButtonTitle:@"回到主菜单"
                                          otherButtonTitles:nil] ;
    [alert show] ;
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self reset] ;
    
}
-(void)reset{
    self.score = 0 ;
    self.scoreLabel.text = nil ;
    _time = 0 ;
    [self setWholeGameModel] ;
    for (EnemyView *enemyView in self.enemyViewSet){
        [enemyView removeFromSuperview];
    }
    [self.enemyViewSet removeAllObjects];
    
    for (BulletView *bulletView in self.bulletViewSet){
        [bulletView removeFromSuperview];
    }
    [self.bulletViewSet removeAllObjects];
}*/

//点击移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject] ;
    CGPoint touchLocation = [touch locationInView:self.view] ;
    CGPoint previousLocation = [touch previousLocationInView:self.view] ;
    //处理我方飞机移动
    CGPoint delta = CGPointMake(touchLocation.x - previousLocation.x, touchLocation.y - previousLocation.y) ;
    CGPoint previousPosition = self.gameModel.airFighter.position ;
    CGPoint newPosition = CGPointMake(previousPosition.x+delta.x, previousPosition.y+delta.y) ;
    
    if(newPosition.x < self.gameModel.airFighter.size.width/2){
        newPosition.x = self.gameModel.airFighter.size.width/2 ;
    }else if(newPosition.x > self.gameModel.gameArea.size.width - self.gameModel.airFighter.size.width/2){
        newPosition.x = self.gameModel.gameArea.size.width - self.gameModel.airFighter.size.width/2 ;
    }
    
    if(newPosition.y <= self.gameModel.airFighter.size.height/2){
        newPosition.y = self.gameModel.airFighter.size.height/2 ;
    }else if(newPosition.y > self.gameModel.gameArea.size.height - self.gameModel.airFighter.size.height/2){
        newPosition.y = self.gameModel.gameArea.size.height - self.gameModel.airFighter.size.height/2 ;
    }
    
    self.gameModel.airFighter.position = newPosition ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
