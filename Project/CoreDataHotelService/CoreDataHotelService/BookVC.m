//
//  BookVC.m
//  CoreDataHotelService
//
//  Created by Jacob Dobson on 11/29/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

#import "BookVC.h"
#import"AvailabilityVC.h"
#import "AutoLayout.h"
#import "AppDelegate.h" //will be saving to the Core Data context...
#import "Room+CoreDataClass.h"
#import "Hotel+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"
#import "Guest+CoreDataClass.h"

@interface BookVC ()

@property(strong, nonatomic) UITextField *firstNameField;
@property(strong, nonatomic) UITextField *lastNameField;
@property(strong, nonatomic) UITextField *emailField;

@end

@implementation BookVC

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupMessageLabel];
    [self setupTextFields];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                            target:self
                                                                                            action:@selector(saveButtonSelected:)]];
}

-(void)viewDidLoad {
    [super viewDidLoad];

}

-(void)setupMessageLabel {
    UILabel *messageLabel = [[UILabel alloc]init];
    
    messageLabel.textAlignment = NSTextAlignmentCenter; //give text alignment of center by assigning from enum
    messageLabel.numberOfLines = 0; //so text will not get truncated
    
    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:messageLabel];
    
    CGFloat myMargin = 20.0;
    
    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:messageLabel toView:self.view];
    leading.constant = myMargin;
    
    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:messageLabel toView:self.view];
    trailing.constant = -myMargin;
    
    [AutoLayout createGenericConstraintFrom:messageLabel
                                     toView:self.view
                              withAttribute:NSLayoutAttributeCenterY];
    messageLabel.text = [NSString stringWithFormat:@"Reservation At:%@\nRoom:%i\nFrom: %@ - %@", self.room.hotel.hotelName, self.room.roomNumber, self.startDate, self.endDate];//dont forget to add self.startDate for hw
}

-(void)setupTextFields {
    //initilaizers
    self.firstNameField = [[UITextField alloc]init];
    self.lastNameField = [[UITextField alloc]init];
    self.emailField = [[UITextField alloc]init];
    
    //placeholders
    self.firstNameField.placeholder = @"enter your first name...";
    self.lastNameField.placeholder = @"enter your last name...";
    self.emailField.placeholder = @"enter your email address...";
    
    //sizing masks
    [self.firstNameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.lastNameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.emailField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //add subviews
    [self.view addSubview:self.firstNameField];
    [self.view addSubview:self.lastNameField];
    [self.view addSubview:self.emailField];
    
    CGFloat myMargin = 20.0; //magic number for margin
    CGFloat navAndStatusBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame) + myMargin; // + "20.0" to account for status bar
    
    //firstNameField Constraints
    NSLayoutConstraint *top = [AutoLayout createGenericConstraintFrom:self.firstNameField
                                                               toView:self.view
                                                        withAttribute:NSLayoutAttributeTop];
    top.constant = navAndStatusBarHeight + myMargin;
    
    NSLayoutConstraint *firstNameleading = [AutoLayout createLeadingConstraintFrom:self.firstNameField toView:self.view];
    firstNameleading.constant = myMargin;
    
    NSLayoutConstraint *firstNametrailing = [AutoLayout createLeadingConstraintFrom:self.firstNameField toView:self.view];
    firstNametrailing.constant = myMargin;
    
    //lastNameField constraints
    NSLayoutConstraint *topToFirstNameField = [AutoLayout createGenericConstraintFrom:self.lastNameField
                                                                               toView:self.firstNameField
                                                                        withAttribute:NSLayoutAttributeTop];
    topToFirstNameField.constant = 36;
    
    NSLayoutConstraint *lastNameLeading = [AutoLayout createLeadingConstraintFrom:self.lastNameField toView:self.view];
    lastNameLeading.constant = myMargin;
    NSLayoutConstraint *lastNameTrailing = [AutoLayout createTrailingConstraintFrom:self.lastNameField toView:self.view];
    lastNameTrailing.constant = myMargin;
    
    //emailField constraints
    NSLayoutConstraint *topToLastNameField = [AutoLayout createGenericConstraintFrom:self.emailField
                                                                              toView:self.lastNameField
                                                                       withAttribute:NSLayoutAttributeTop];
    topToLastNameField.constant = 36;
    
    NSLayoutConstraint *emailLeading = [AutoLayout createLeadingConstraintFrom:self.emailField toView:self.view];
    emailLeading.constant = myMargin;
    NSLayoutConstraint *emailTrailing = [AutoLayout createTrailingConstraintFrom:self.emailField toView:self.view];
    emailTrailing.constant = myMargin;
    
    [self.emailField becomeFirstResponder]; //pulls up the keyboard when clicked on
}

//what to do when they click on the save button
-(void)saveButtonSelected:(UIBarButtonItem *)sender {
    
    // if text fields are empty...do not create reservation! -- error handling here..
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate]; // delegate is id, so cast into AppDelegate
    
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
    
    reservation.startDate = [NSDate date];
    reservation.endDate = self.endDate;
    reservation.room = self.room;
    
    self.room.reservations = [self.room.reservations setByAddingObject:reservation]; //adds reservation to that set and replaces the new one (calulate what's on right and reassinging it back into itself) called "pointer manipulation"
    
    //assigning user text input to guest reservations object
    reservation.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
    reservation.guest.firstName = self.firstNameField.text;
    reservation.guest.lastName = self.lastNameField.text;
    reservation.guest.email = self.emailField.text;
    
    NSError *saveError;
    [context save:&saveError];
    
    if (saveError) {
        NSLog(@"There was an error saving new reservation");
    } else {
        NSLog(@"Saved Reservation Successfully!");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
