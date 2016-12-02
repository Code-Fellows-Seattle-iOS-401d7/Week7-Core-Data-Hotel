//
//  LookupViewController.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/30/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <Flurry.h>
#import "LookupViewController.h"
#import "AutoLayout.h"
#import "AppDelegate.h"
#import "Reservation+CoreDataClass.h"
#import "Guest+CoreDataClass.h"
#import "ReservationService.h"

@interface LookupViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property(strong, nonatomic) UISearchBar* searchBar;
@property(strong, nonatomic) UITableView* tableView;

@property(strong, nonatomic) NSArray *reservationsList;

@property(strong, nonatomic) ReservationService *reservationService;

@end

@implementation LookupViewController

- (void) loadView {
    [super loadView];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"Lookup"];
    [self setupLookupView];

   // self.searchResults = [self getSearchResults:@"filizk@live.com"];

}

- (void) setupLookupView {
    self.searchBar = [[UISearchBar alloc] init];
    self.tableView = [[UITableView alloc]init];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchBar];


    [self.searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [AutoLayout createLeadingConstraintFrom:self.searchBar toView:self.view];

    [AutoLayout createTrailingConstraintFrom:self.searchBar toView:self.view];

    [AutoLayout createLeadingConstraintFrom:self.tableView toView:self.view];

    [AutoLayout createTrailingConstraintFrom:self.tableView toView:self.view];

    NSLayoutConstraint *top = [AutoLayout createGenericConstraintFrom:self.searchBar toView:self.view withAttribute:NSLayoutAttributeTop];
    top.constant = kstatusBarHeight + 44;


    NSLayoutConstraint *top2 = [AutoLayout createGenericConstraintFrom:self.tableView toView:self.searchBar withAttribute:NSLayoutAttributeTop];
    top2.constant = CGRectGetHeight(self.searchBar.frame);

    [AutoLayout createGenericConstraintFrom:self.tableView toView:self.view withAttribute:NSLayoutAttributeBottom];

}

//- (NSArray *) getSearchResults:(NSString *)searchText {
//    NSArray *results;
//    AppDelegate *appDelegate =(AppDelegate *) [[UIApplication sharedApplication]delegate];
//    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
//
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
//    request.predicate = [NSPredicate predicateWithFormat:@"guest.email == %@", searchText];
//
//    NSError *fetchError;
//     results = [context executeFetchRequest:request error:&fetchError];
//
//    if(fetchError){
//        NSLog(@"There was an issue with our Reservation Fetch.");
//        return nil;
//    }
//    return results;
//}
//
//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.reservationService = [ReservationService shared];
    self.reservationsList = [self.reservationService retrieveAllReservations];
    [Flurry logEvent:@"Timed_User_Search" timed:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reservationsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    Reservation *rez = self.reservationsList[indexPath.row];
    cell.textLabel.text = rez.guest.firstName;
    return cell;

}

- (NSArray *)filterContentForSearchText:(NSString*)searchText {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"guest.firstName contains[c] %@", searchText];
    return [self.reservationsList filteredArrayUsingPredicate:resultPredicate];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.reservationsList = [self.reservationService reservationSearchWithGuestName:searchText];
    self.tableView.reloadData;
    [Flurry logEvent:@"User searched rezervations"];
    [Flurry endTimedEvent:@"Timed_User_Search" withParameters:nil];
}



@end
