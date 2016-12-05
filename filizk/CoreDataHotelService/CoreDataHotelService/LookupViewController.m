//
//  LookupViewController.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/30/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//


#import "LookupViewController.h"
#import "AutoLayout.h"
#import "AppDelegate.h"
#import "Reservation+CoreDataClass.h"
#import "Guest+CoreDataClass.h"
#import "ReservationService.h"
#import "CustomTableViewCell.h"
#import "RoomsViewController.h"
#import "NSString+Common.h"

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


  
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
    self.tableView.cellLayoutMarginsFollowReadableWidth = NO;

    [self.searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];

    [AutoLayout createLeadingConstraintFrom:self.searchBar toView:self.view];
    [AutoLayout createTrailingConstraintFrom:self.searchBar toView:self.view];

    [AutoLayout createLeadingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout createTrailingConstraintFrom:self.tableView toView:self.view];

    NSLayoutConstraint *top = [AutoLayout createGenericConstraintFrom:self.searchBar toView:self.view withAttribute:NSLayoutAttributeTop];
    top.constant = kstatusBarHeight + 44;


    NSLayoutConstraint *topTableView = [AutoLayout createGenericConstraintFrom:self.tableView toView:self.searchBar withAttribute:NSLayoutAttributeTop];
    topTableView.constant = CGRectGetHeight(self.searchBar.frame);

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

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reservationsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];


    Reservation *rez = self.reservationsList[indexPath.row];
    NSString *guestInfo= [rez.guest.firstName stringByAppendingString:rez.guest.lastName];
    NSString *hotelInfo = [rez.room.hotel.name stringByAppendingString:[NSString stringWithFormat:@"%i",rez.room.number]];
    NSString *dates = [[[[NSString alloc] init] formatDateToString:rez.startDate] stringByAppendingString:[[[NSString alloc] init] formatDateToString:rez.endDate]];

    cell.hotelDetails.text = hotelInfo;
    cell.stayDetails.text = [guestInfo stringByAppendingString:dates];

    return cell;

}

- (NSArray *)filterContentForSearchText:(NSString*)searchText {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"guest.firstName contains[c] %@", searchText];
    return [self.reservationsList filteredArrayUsingPredicate:resultPredicate];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.reservationsList = [self.reservationService reservationSearchWithGuestName:searchText];
    self.tableView.reloadData;

}

//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    /* Check Content Size and Set Height */
//    //    CGRect answerFrame = [YOUR_LABEL.text boundingRectWithSize:CGSizeMake(240.f, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont fontWithName:@"" size:14.0f]} context:nil];
//    //
//    //    CGSize requiredSize = answerFrame.size;
//
//    
//    return 20.0;
//}



@end
