//
//  ViewController.m
//  AirFighter
//
//  Created by LAgagggggg on 21/03/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//

#import "MainMenu.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface MainMenu ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
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
    //设置换头像button
    UIButton * changeAvatorButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    changeAvatorButton.frame = self.avatarView.frame ;
 /*   NSLog(@"self %f%f  %f%f",self.avatarView.frame.origin.x,self.avatarView.frame.origin.y
          ,self.avatarView.frame.size.width,self.avatarView.frame.size.height) ;
    NSLog(@"button %f%f  %f%f",changeAvatorButton.frame.origin.x,changeAvatorButton.frame.origin.y,changeAvatorButton.frame.size.width,changeAvatorButton.frame.size.height) ; */
    changeAvatorButton.backgroundColor = [UIColor clearColor] ;
    [changeAvatorButton addTarget:self action:@selector(changeAvatorImage) forControlEvents:UIControlEventTouchUpInside] ;
    
    [self.view addSubview:changeAvatorButton] ;
    //参数回传
    self.score = [[NSMutableArray alloc] init] ;
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveScore:) name:@"GameViewReturn" object:nil] ;
}

//传递参数
-(void)receiveScore :(NSNotification *)notification{
    NSNumber * score = notification.object ;
    //接收分数并且排序，归档
    [self.score addObject:score] ;
    
    [self.score sortUsingComparator:^(NSNumber * obj1 , NSNumber * obj2){
        NSInteger x1 = [obj1 integerValue] ;
        NSInteger x2 = [obj2 integerValue] ;
        return (x1<=x2)? NSOrderedDescending : NSOrderedAscending ;
        }] ;
    NSLog(@"%@",self.score) ;
    //归档
    NSString * file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"score.data"] ;
    [NSKeyedArchiver archiveRootObject:self.score toFile:file] ;
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}
//更换头像
-(void)changeAvatorImage{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
        if (granted) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
    NSLog(@"haha");
    UIAlertController * actionSheet ;
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        actionSheet = [UIAlertController alertControllerWithTitle:@"choose Image"
                                                          message:@"请选择一种方式"
                                                   preferredStyle:UIAlertControllerStyleActionSheet] ;
        
        UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action){
                                                            UIImagePickerController * cameraController = [[UIImagePickerController alloc] init] ;
                                                            cameraController.delegate = self ;
                                                            cameraController.allowsEditing = YES ;
                                                            cameraController.editing = YES ;
                                                            //相机相关属性
                                                            cameraController.sourceType = UIImagePickerControllerSourceTypeCamera ;
                                                            cameraController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto ;
                                                            cameraController.modalPresentationStyle = UIModalPresentationFullScreen ;
                                                            cameraController.mediaTypes = @[(NSString *) kUTTypeImage];
                                                            
                                                            [self presentViewController:cameraController animated:YES completion:nil] ;
                                                            
                                                        }];
        UIAlertAction * photograph = [UIAlertAction actionWithTitle:@"从相册选择"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action){
                                                                UIImagePickerController * photoController = [[UIImagePickerController alloc] init] ;
                                                                photoController.delegate = self ;
                                                                photoController.allowsEditing = YES ;
                                                                photoController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
                                                                [self presentViewController:photoController animated:YES completion:nil] ;
                                                                }];
        [actionSheet addAction:camera] ;
        [actionSheet addAction:photograph] ;
        [self presentViewController:actionSheet animated:YES completion:nil] ;
  //  };
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil] ;
    
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage] ;
    [self uploadImage:image] ;
}
-(void)uploadImage:(UIImage *)image{
    self.avatarView.image = image ;
    [self reloadInputViews] ;//
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
