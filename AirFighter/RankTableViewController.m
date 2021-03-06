//
//  RankTableViewController.m
//  AirFighter
//
//  Created by LAgagggggg on 21/03/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//

#import "RankTableViewController.h"

@interface RankTableViewController ()

@end

@implementation RankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    self.tableView.backgroundColor=[UIColor grayColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //设置tableview
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0) ;
    NSString * file =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"score.data"] ;
    
    self.scoreArray = [NSKeyedUnarchiver unarchiveObjectWithFile:file] ;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.scoreArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] ;
    }
    // Configure the cell...
    cell.textLabel.textColor = [UIColor whiteColor] ;
    NSInteger num = indexPath.row ;
    int score = (int)[[self.scoreArray objectAtIndex:num] integerValue] ;
    cell.backgroundColor = [UIColor grayColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",score] ;
    cell.textLabel.textColor = [UIColor redColor] ;
    NSLog(@"cell: %@",cell.textLabel.text) ;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
