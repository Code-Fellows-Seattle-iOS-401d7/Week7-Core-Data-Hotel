//
//  ReservationService.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 12/1/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "ReservationService.h"
#import "AppDelegate.h"
#import "Room+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"
#import "Hotel+CoreDataClass.h"
#import "Guest+CoreDataClass.h"

@interface ReservationService ()
//atomic is threadsafe.
@property(strong, nonatomic) AppDelegate *delegate;
@property(strong) NSManagedObjectContext *context;
@end

@implementation ReservationService

+(instancetype)shared {
    static ReservationService *shared = nil;

    static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            shared = [[ReservationService alloc]init];
        });
    return shared;
}

-(instancetype)init{
    self = [super init];

    if (self) {
        _delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        _context = _delegate.persistentContainer.viewContext;
    }
    return self;
}


-(NSArray *)getRoomsForHotelNamed:(NSString *)hotelName {
    NSArray *hotelsList;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    request.predicate = [NSPredicate predicateWithFormat:@"hotel.name == %@", hotelName];

    NSError *requestError;
    hotelsList = [self.context executeFetchRequest:request error:&requestError];

    if (requestError) {
        NSLog(@"Error requesting data from Core Data");
    }
    return hotelsList;
}

-(NSFetchedResultsController *)getAvailableRoomsForDates:(NSDate *)startDate andEndDate:(NSDate *)endDate {
    NSFetchedResultsController *roomsList;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ && endDate > %@", startDate, endDate];

    NSError *requestError;
    NSArray *results = [self.context executeFetchRequest:request error:&requestError];

    if(requestError){
        NSLog(@"There was an issue with our Reservation Fetch.");
    }

    NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];

    for (Reservation *reservation in results){
        [unavailableRooms addObject:reservation.room];
    }

    NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
    roomRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:YES]];


    NSError *roomRequestError;
    //_availableRooms = [context executeFetchRequest:roomRequest error:&roomRequestError];
    roomsList = [[NSFetchedResultsController alloc]initWithFetchRequest:roomRequest managedObjectContext:self.context sectionNameKeyPath:@"hotel.name" cacheName:nil];
    [roomsList performFetch:&roomRequestError];

    if (roomRequestError) {
        NSLog(@"There was an error requesting available rooms.");
    }

    return roomsList;

}

-(NSArray *)getAllHotelsList{
     return [[NSArray alloc]init];

}
-(BOOL)completeReservation:(NSDate *)startDate andEndDate:(NSDate *)endDate room:(Room *)room guestFirstName:(NSString *)firstName guestLastName:(NSString *)lastName guestEmail:(NSString *)email {
    BOOL result = YES;

    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.context];

    reservation.startDate = [NSDate date];
    reservation.endDate = endDate;
    reservation.room = room;

    //does pointer manipulation below to add and create new array and assign that to itself.
    //kind of like this: constraints = [constraints arrayByAddingObjectsFromArray:horizantalConstraints];
    room.reservations = [room.reservations setByAddingObject:reservation];

    reservation.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.context];
    reservation.guest.firstName = firstName;
    reservation.guest.lastName = lastName;
    reservation.guest.email = email;

    NSError *saveError;
    [self.context save:&saveError];

    if(saveError){
        NSLog(@"There was an error saving new reservation.");
    } else {
        NSLog(@"Saving successfull");
        //[Flurry logEvent:@"Reservation_Booked"];
        //NSDictionary *parameters = @{@"GuestName":reservation.guest.firstName};
        //[Flurry logEvent:@"Reservation_Booked" withParameters:parameters timed:YES];

       
    }
    return result;

}
-(NSArray *) reservationSearchWithGuestName:(NSString *)name{
    NSArray *results;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"guest.firstName contains[c] %@", name];

    NSError *fetchError;
    results = [self.context executeFetchRequest:request error:&fetchError];

    if(fetchError){
        NSLog(@"There was an issue with our Reservation Fetch.");
    }
    return results;
}

-(NSArray *) retrieveAllReservations {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    NSError *fetchError;
    return [self.context executeFetchRequest:request error:&fetchError];
}
@end
