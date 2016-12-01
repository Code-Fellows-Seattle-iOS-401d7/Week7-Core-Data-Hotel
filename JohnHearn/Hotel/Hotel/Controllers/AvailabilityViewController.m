//
//  AvailabilityViewController.m
//  Hotel
//
//  Created by John D Hearn on 11/29/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "AutoLayout.h"
#import "BookViewController.h"
#import "Room+CoreDataClass.h"
#import "Hotel+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"

@interface AvailabilityViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSFetchedResultsController *availableRooms;
@end


@implementation AvailabilityViewController
-(NSFetchedResultsController *)availableRooms{
    if(!_availableRooms){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;

        //TODO: this isn't very self-documenting. Explain why we have to find unavailable rooms first.
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@",
                                                             self.endDate,
                                                             [NSDate date]];

        NSError *requestError;
        NSArray *results = [context executeFetchRequest:request error:&requestError];
        if(requestError){
            NSLog(@"There was an issue with our Reservation Fetch.");
            return nil;
        }
        NSMutableArray *unavailableRooms = [[NSMutableArray alloc] init];
        for(Reservation *reservation in results) {
            [unavailableRooms addObject:reservation.room];
        }

        NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
        roomRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:YES],
                                         [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES] ];



        NSError *roomRequestError;
        /* Note: _availableRooms used to be an NSArray */
        //_availableRooms = [context executeFetchRequest:roomRequest error:&roomRequestError];
        _availableRooms = [[NSFetchedResultsController alloc] initWithFetchRequest:roomRequest
                                                              managedObjectContext:context
                                                                sectionNameKeyPath:@"hotel.name"
                                                                         cacheName:nil];
        [_availableRooms performFetch:&roomRequestError];

        if(roomRequestError){
            NSLog(@"There was an issue with requesting available rooms.");
        }

        //TODO: If count of unavailable rooms is 0 let user know.

    }

    return _availableRooms;
}

-(void)loadView{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupTableView];
    [self setTitle:@"Rooms"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [AutoLayout activateFullViewConstraintsUsingVFLFor:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];

    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell"];
    }

    Room *room = [self.availableRooms objectAtIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"Room %i\n($%.2f/night, %i beds)",
                                                     room.number,
                                                     room.rate.floatValue,
                                                     room.beds];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.availableRooms sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.availableRooms.sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.availableRooms sections] objectAtIndex:section];
    Room *room = [[sectionInfo objects] objectAtIndex:section];
    return room.hotel.name;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Room *room = [self.availableRooms objectAtIndexPath:indexPath];

    BookViewController *bookVC = [[BookViewController alloc] init];
    bookVC.room = room;
    bookVC.startDate = self.startDate;
    bookVC.endDate = self.endDate;

    [self.navigationController pushViewController:bookVC animated:YES];
}

@end