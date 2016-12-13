//
//  BookVC.h
//  CoreDataHotelService
//
//  Created by Jacob Dobson on 11/29/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room+CoreDataClass.h"

@interface BookVC : UIViewController

@property(strong, nonatomic) Room *room;
@property(strong, nonatomic) NSDate *startDate;
@property(strong, nonatomic) NSDate *endDate;

@end
