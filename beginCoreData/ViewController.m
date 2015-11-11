//
//  ViewController.m
//  beginCoreData
//
//  Created by cq on 15/11/11.
//  Copyright © 2015年 顺苹亓. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray * names;
@property(strong,nonatomic) NSMutableArray * people;
@property(strong,nonatomic)NSArray *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"The List";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.names=[NSMutableArray  arrayWithCapacity:5];
    self.people=[NSMutableArray arrayWithCapacity:6];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.people.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    self.person=[self.people objectAtIndex:indexPath.row];
    cell.textLabel.text=[self.person valueForKey:@"name"];
    return cell;
}
- (IBAction)addName:(id)sender {
    
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"New names"
                                                                   message:@"Add a new name" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * saveAlert=[UIAlertAction actionWithTitle:@"save"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       UITextField * textField=alert.textFields.firstObject;
                                                       [self saveName:textField.text];
                                                       [self.names addObject:textField.text];
                                                       [self.tableView reloadData];
                                                   }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"cancel"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              
                                                          }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"names";
    }];
    [alert addAction:saveAlert];
    [alert addAction:cancelAction];
     
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)saveName:(NSString*)name{
    NSManagedObjectContext * context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSManagedObject * person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [person setValue:name forKey:@"name"];
    [context save:nil];
    [_people addObject:person];
}

- (void)viewDidAppear:(BOOL)animated{
    NSManagedObjectContext *context=[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest * fetchRequest =[NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSArray * result = [context executeFetchRequest:fetchRequest error:nil];
    _people=[[NSMutableArray alloc]initWithArray:result];
}
@end
