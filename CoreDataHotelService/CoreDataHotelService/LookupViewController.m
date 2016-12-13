//
//  LookupViewController.m
//  CoreDataHotelService
//
//  Created by Corey Malek on 11/30/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import <Flurry.h>
#import "LookupViewController.h"
#import "AppDelegate.h"
#import "Hotel+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"
#import "Guest+CoreDataClass.h"
#import "AutoLayout.h"
#import "AvailabilityViewController.h"



@interface LookupViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property(strong, nonatomic) NSArray *dataSource;
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) UITextField *nameField;
@property(strong, nonatomic) UITextField *numberField;
@property(strong, nonatomic) UITextField *emailField;
@property(strong, nonatomic) NSMutableArray *searchedReservation;

@end

@implementation LookupViewController


//create searchBarButtonClicked method, input following code:
// [Flurry logEvent: @"User_Searched_Reservations"];
// [Flurry logEvent:@"Timed_User_Search" withParameters: nil];

- (void)viewDidLoad {
    [super viewDidLoad];
    [Flurry logEvent:@"Timed_User_Search" timed:YES];
}


-(void)loadView{
    [super loadView];
    [self setUpSearchBar];
    [self setUpTableView];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;

    
    [self setTitle:@"Reservations"];
    
    
    CGFloat myMargin = 62.0;
    [AutoLayout createLeadingConstraintFrom:self.searchBar toView:self.view];
    [AutoLayout createTrailingConstraintFrom:self.searchBar toView:self.view];
    NSLayoutConstraint *top = [AutoLayout createGenericConstraintFrom:self.searchBar toView:self.view withAttribute:NSLayoutAttributeTop];
    top.constant = myMargin;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [AutoLayout createLeadingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout createTrailingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout createTopToBottomRelationFrom:self.tableView toView:self.searchBar];
    [AutoLayout createGenericConstraintFrom:self.tableView toView:self.view withAttribute:NSLayoutAttributeBottom];
    
}





-(void)setUpSearchBar{
    
    self.searchBar = [[UISearchBar alloc]init];
    [self.view addSubview:self.searchBar];
    self.searchBar.placeholder = @"Search Reservation..";
    [self.searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}



-(void)setUpTableView{
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Reservation *reservation = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Name: %@, Reservation: %@", reservation.guest.name, reservation.room];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource count];
    
}



-(void)searchButtonClicked:(UISearchBar *)searchBar{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"guest.name == %@", searchBar.text];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if(!error){
        self.dataSource = results;
    }
    
    
}










































@end


