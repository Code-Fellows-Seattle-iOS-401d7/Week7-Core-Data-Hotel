//
//  RoomsViewController.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/28/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "RoomsViewController.h"
#import "AutoLayout.h"
#import "AppDelegate.h"
#import "Room+CoreDataClass.h"

@interface RoomsViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic)NSArray *rooms;
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation RoomsViewController

-(void)loadView {
    [super loadView];

    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [AutoLayout activateFullViewConstraintsUsingVFLFor:self.tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"Rooms"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray *)rooms{
    if (!_rooms) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = delegate.persistentContainer.viewContext;

        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        request.predicate = [NSPredicate predicateWithFormat:@"hotel == %@", self.hotel];

        NSError *requestError;
        _rooms = [context executeFetchRequest:request error:&requestError];

        if (requestError) {
            NSLog(@"Error requesting data from Core Data");
        }
    }
    return _rooms;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    Room *room = self.rooms[indexPath.row];
    
    NSString *string = [NSString stringWithFormat:@"Room: %i (%i beds, $%0.2f per night). ", room.number, room.beds, room.rate.floatValue];
    cell.textLabel.text = string;
    return cell;
}

@end
