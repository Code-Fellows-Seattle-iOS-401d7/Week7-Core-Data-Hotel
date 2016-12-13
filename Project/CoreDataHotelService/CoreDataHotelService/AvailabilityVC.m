//
//  AvailabilityVC.m
//  CoreDataHotelService
//
//  Created by Jacob Dobson on 11/29/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

#import "AvailabilityVC.h"
#import "BookVC.h"
#import "AppDelegate.h"
#import "AutoLayout.h"
#import "Reservation+CoreDataClass.h"
#import "Hotel+CoreDataClass.h"
#import "Room+CoreDataClass.h"

@interface AvailabilityVC () <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) UITableView *availabilityTableView;
@property(strong, nonatomic) NSArray *availableRoomsDataSource; //dataSource as a backing array, not for the tableView

@end

@implementation AvailabilityVC

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupTableView];
    [self setTitle:@"Available Rooms"];
}

-(void)viewDidLoad {
    [super viewDidLoad];

}

-(NSArray *)availableRooms {
    //creating lazy property...
    if (!_availableRoomsDataSource) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %a && endDate is >= %a", self.startDate, [NSDate date]];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %a && endDate is >= %a", self.endDate, [NSDate date]];
        
        NSError *requestError;
        NSArray *results = [context executeFetchRequest:request error:&requestError];
        
        if (requestError) {
            NSLog(@"There was an issue with our reservation fetch.");
            return nil;
        }
        NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
        
        for (Reservation *reservation in results) {
            [unavailableRooms addObject:reservation.room];
        }
        NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
        
        NSError *roomRequestError;
        _availableRoomsDataSource = [context executeFetchRequest:roomRequest error:&roomRequestError];
        
        if (roomRequestError) {
            NSLog(@"There was an error requesting available rooms");
        }
    }
    return _availableRoomsDataSource;
}

-(void)setupTableView {
    self.availabilityTableView = [[UITableView alloc]init];
    self.availabilityTableView.dataSource = self;
    self.availabilityTableView.delegate = self;
    self.availabilityTableView.translatesAutoresizingMaskIntoConstraints = NO; //has to be before the subview
    
    [self.view addSubview:self.availabilityTableView];
    
    [self.availabilityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [AutoLayout activateFullViewConstraintsUsingVFLFor:self.availabilityTableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                        forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Room *room = self.availableRoomsDataSource[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Room: %i(%i beds, $%.2f)",   room.roomNumber,
                                                                                    room.beds,
                                                                                    room.rate.floatValue];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.availableRoomsDataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Room *room = self.availableRoomsDataSource[indexPath.row];
    
    BookVC *bookVC = [[BookVC alloc]init];
    bookVC.room = room;
    bookVC.endDate = self.endDate;
    //bookVC.startDate = self.startDate;
    
    [self.navigationController pushViewController:bookVC animated:YES];
}

@end
