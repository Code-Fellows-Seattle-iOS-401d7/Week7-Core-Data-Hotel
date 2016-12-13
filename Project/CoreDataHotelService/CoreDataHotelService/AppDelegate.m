//
//  AppDelegate.m
//  CoreDataHotelService
//
//  Created by Jacob Dobson on 11/28/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "Hotel+CoreDataClass.h"
#import "Room+CoreDataClass.h"

@interface AppDelegate ()

@property(strong, nonatomic) UINavigationController *navigationController;
@property(strong, nonatomic) ViewController *viewController;

@end

@implementation AppDelegate


-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupRootViewController];
    
    [self bootstrapApp];
    
    return YES;
}

-(void)setupRootViewController{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    self.viewController = [[ViewController alloc]init];
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    
}


-(void)bootstrapApp{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    
    NSError *error;
    NSInteger count = [self.persistentContainer.viewContext countForFetchRequest:request error:&error];
    
    if(error){
        NSLog(@"Error Getting count of Hotels from Core Data.");
        return;
    }
    
    if(count == 0){
        NSDictionary *hotels = [[NSDictionary alloc]init];
        NSDictionary *rooms = [[NSDictionary alloc]init];
        
        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"hotels" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        
        NSError *jsonError;
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
        
        if(jsonError){
            NSLog(@"Error Serializing JSON");
            return;
        }
        
        hotels = rootObject[@"Hotels"];
        
        for(NSDictionary *hotel in hotels){
            
            Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.persistentContainer.viewContext];
            
            newHotel.hotelName = hotel[@"name"];
            newHotel.location = hotel[@"location"];
            newHotel.stars = (NSInteger)hotel[@"stars"];
            
            rooms = hotel[@"rooms"];
            
            for (NSDictionary *room in rooms) {
                Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.persistentContainer.viewContext];
                
                newRoom.roomNumber = (NSInteger)room[@"number"];
                newRoom.beds = (NSInteger)room[@"beds"];
                newRoom.rate = (NSDecimalNumber *)room[@"rate"];
                
                newRoom.hotel = newHotel;
            }
        }
        
        NSError *saveError;
        BOOL isSaved = [self.persistentContainer.viewContext save:&saveError];
        
        if(isSaved){
            NSLog(@"Saved Successfully To Core Data!");
        } else {
            NSLog(@"Save Unsuccesssful - SAVE ERROR: %@", saveError.localizedDescription);
        }
    }
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

-(NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreDataHotelService"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

-(void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
