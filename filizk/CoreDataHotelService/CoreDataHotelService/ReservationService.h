//
//  ReservationService.h
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 12/1/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataHotelService+CoreDataModel.h"

@interface ReservationService : NSObject

+(instancetype)shared;
-(NSArray *)getRoomsForHotelNamed:(NSString *)hotelName;
-(NSFetchedResultsController *)getAvailableRoomsForDates:(NSDate *)startDate andEndDate:(NSDate *)endDate;
-(NSArray *)getAllHotelsList;
-(BOOL)completeReservation:(NSDate *)startDate andEndDate:(NSDate *)endDate room:(Room *)room guestFirstName:(NSString *)firstName guestLastName:(NSString *)lastName guestEmail:(NSString *)email;
-(NSArray *) reservationSearchWithGuestName:(NSString *)name;
-(NSArray *) retrieveAllReservations;

@end
