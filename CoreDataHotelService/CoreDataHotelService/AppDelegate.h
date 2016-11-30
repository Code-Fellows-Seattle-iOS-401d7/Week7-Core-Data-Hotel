//
//  AppDelegate.h
//  CoreDataHotelService
//
//  Created by Corey Malek on 11/28/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

