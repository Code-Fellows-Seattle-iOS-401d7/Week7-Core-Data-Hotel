//
//  AvailabilityViewController.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/29/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation+CoreDataClass.h"
#import "AutoLayout.h"
#import "Room+CoreDataProperties.h"
#import "BookViewController.h"

@interface AvailabilityViewController () <UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSArray *availableRooms;
@end

@implementation AvailabilityViewController

-(void)loadView{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupTableView];
    [self setTitle:@"Rooms"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setupTableView {
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [AutoLayout activateFullViewConstraintsUsingVFLFor:self.tableView];


}

//equvalent of lazy property in Swift.
-(NSArray *)availableRooms{
    if (!_availableRooms) {
        AppDelegate *appDelegate =(AppDelegate *) [[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;

        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ && endDate > %@", self.startDate, self.endDate];

        NSError *requestError;
        NSArray *results = [context executeFetchRequest:request error:&requestError];

        if(requestError){
            NSLog(@"There was an issue with our Reservation Fetch.");
            return nil;
        }

        NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];

        for (Reservation *reservation in results){
            [unavailableRooms addObject:reservation.room];
        }

        NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];

        NSError *roomRequestError;
        _availableRooms = [context executeFetchRequest:roomRequest error:&roomRequestError];

        if (roomRequestError) {
            NSLog(@"There was an error requesting available rooms.");
        }
    }

    return _availableRooms;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    Room *room = self.availableRooms[indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"Room: %i(%i beds, $%0.2f/night)", room.number, room.beds, room.rate.floatValue];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.availableRooms.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BookViewController *bookVC = [[BookViewController alloc]init];
    bookVC.room = self.availableRooms[indexPath.row];
    bookVC.startDate = self.startDate;
    bookVC.endDate = self.endDate;
    
    [self.navigationController pushViewController:bookVC animated:YES];
}

@end
