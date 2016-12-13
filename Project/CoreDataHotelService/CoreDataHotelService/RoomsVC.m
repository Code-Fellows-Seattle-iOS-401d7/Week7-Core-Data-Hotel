//
//  RoomsVC.m
//  CoreDataHotelService
//
//  Created by Jacob Dobson on 11/29/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

#import "RoomsVC.h"
#import "AutoLayout.h"
#import "AppDelegate.h"
#import "Hotel+CoreDataClass.h"
#import "Room+CoreDataClass.h"


@interface RoomsVC () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic)NSArray *dataSource;
@property(strong, nonatomic)UITableView *roomsTableView;

@end

@implementation RoomsVC

-(void)loadView {
    [super loadView];
    
    self.roomsTableView = [[UITableView alloc]init];
    self.roomsTableView.dataSource = self;
    
    self.roomsTableView.delegate = self;
    self.roomsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.dataSource = self.hotel.rooms.allObjects;
    
    [self.view addSubview:self.roomsTableView];
    [self.roomsTableView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"cell"];
    
    [AutoLayout activateFullViewConstraintsUsingVFLFor:self.roomsTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Rooms"];
}


//MARK: UITableView Required Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.roomsTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Room *room = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Room: %hd", room.roomNumber];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotel.rooms.count;
}


@end
