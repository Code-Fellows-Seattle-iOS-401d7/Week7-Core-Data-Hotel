//
//  BookViewController.h
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/29/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room+CoreDataProperties.h"

@interface BookViewController : UIViewController

@property(strong, nonatomic) Room *room;
@property(strong, nonatomic) NSDate *startDate;
@property(strong, nonatomic) NSDate *endDate;

@end
