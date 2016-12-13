//
//  LookupViewController.h
//  CoreDataHotelService
//
//  Created by Corey Malek on 11/30/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guest+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"



@interface LookupViewController : UIViewController

@property(strong, nonatomic) Room *room;
@property(strong, nonatomic) Guest *guest;
@property(strong, nonatomic) Reservation *reservation;
@property(strong, nonatomic) UISearchBar *searchBar;


@end
