//
//  LookupViewController.m
//  CoreDataHotelService
//
//  Created by Corey Malek on 11/30/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

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

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)loadView{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUpSearchBar];
    [self setUpTableView];
    [self setTitle:@"Reservations"];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}


-(NSFetchedResultsController *)reservation{
    if(!_reservation){
        AppDelegate *appDelegate
    }
}



-(void)setUpSearchBar{
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;

    self.searchBar.placeholder = @"Search Reservation..";
    self.searchBar.translucent = YES;
    self.searchBar.showsCancelButton = YES;
    [self.searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGFloat myMargin = 20.0;
    
    [self.view addSubview:self.searchBar];
    
    [AutoLayout createLeadingConstraintFrom:self.searchBar toView:self.view];
    
    [AutoLayout createTrailingConstraintFrom:self.searchBar toView:self.view];
    
    NSLayoutConstraint *top = [AutoLayout createGenericConstraintFrom:self.searchBar toView:self.view withAttribute:NSLayoutAttributeTop];
    top.constant = myMargin;
    
}


-(void)setUpTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [AutoLayout createLeadingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout createTrailingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout createTopToBottomRelationFrom:self.tableView toView:self.searchBar];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}














































@end


