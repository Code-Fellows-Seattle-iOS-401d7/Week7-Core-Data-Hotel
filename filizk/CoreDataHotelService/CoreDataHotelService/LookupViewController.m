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

@interface LookupViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property(strong, nonatomic) UISearchBar* searchBar;
@property(strong, nonatomic) UITableView* tableView;

@property(strong, nonatomic) NSArray *searchResults;

@end

@implementation LookupViewController

- (void) loadView {
    [super loadView];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"Lookup"];
    [self setupLookupView];

    self.searchResults = [self getSearchResults:@"filizk@live.com"];

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

    [AutoLayout activateFullViewConstraintsFrom:self.tableView toView:self.view];
  }

- (NSArray *) getSearchResults:(NSString *)searchText {
    NSArray *results;
    AppDelegate *appDelegate =(AppDelegate *) [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"guest.email == %@", searchText];

    NSError *fetchError;
     results = [context executeFetchRequest:request error:&fetchError];

    if(fetchError){
        NSLog(@"There was an issue with our Reservation Fetch.");
        return nil;
    }
    return results;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    Reservation *rez = self.searchResults[indexPath.row];
    cell.textLabel.text = rez.guest.email;
    return cell;

}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSArray *results = [self getSearchResults:searchText];

    self.searchResults = results;
    self.tableView.reloadData;

}


@end
