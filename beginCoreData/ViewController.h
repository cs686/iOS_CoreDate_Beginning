//
//  ViewController.h
//  beginCoreData
//
//  Created by cq on 15/11/11.
//  Copyright © 2015年 顺苹亓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addName:(id)sender;

@end

