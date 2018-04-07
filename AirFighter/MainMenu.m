//
//  ViewController.m
//  AirFighter
//
//  Created by LAgagggggg on 21/03/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//

#import "MainMenu.h"

@interface MainMenu ()
@property (strong, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *rankBtn;
@property (weak, nonatomic) UIImage * myAvatar;//用户头像
@end

@implementation MainMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.startBtn.backgroundColor=[UIColor darkGrayColor];
    self.rankBtn.backgroundColor=[UIColor darkGrayColor];
    self.startBtn.layer.cornerRadius=10.f;
    self.rankBtn.layer.cornerRadius=10.f;
    self.myAvatar=[UIImage imageNamed:@"avatar"];
    [self.avatarView setImage:self.myAvatar];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveScore:) name:@"GameViewReturn" object:nil] ;
}

-(void)receiveScore :(NSNotification *)notification{
    self.score =(long) notification.object ;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}
- (IBAction)RankBtnClicked:(id)sender {
    RankTableViewController * tvc=[[RankTableViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
}
- (IBAction)StartBtnClicked:(id)sender {
    GameViewController * tvc = [[GameViewController alloc] init] ;
    [self.navigationController pushViewController:tvc animated:YES] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
