//
//  BookViewController.m
//  CoreDataHotelService
//
//  Created by Filiz Kurban on 11/29/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "BookViewController.h"
#import "AppDelegate.h"
#import "Hotel+CoreDataClass.h"
#import "Reservation+CoreDataClass.h"
#import "Guest+CoreDataClass.h"
#import "AutoLayout.h"

@interface BookViewController ()
@property(strong, nonatomic) UITextField *firstName;
@property(strong, nonatomic) UITextField *lastName;
@property(strong, nonatomic) UITextField *email;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)loadView {
    [super loadView];

    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self setupMessageLabel];
    [self setupTextFields];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];


}

-(void)setupMessageLabel{
    UILabel *messageLabel = [[UILabel alloc]init];

    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;

    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.view addSubview:messageLabel];

    CGFloat myMargin = 20.0;
    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:messageLabel toView:self.view];
    leading.constant = myMargin;

    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:messageLabel toView:self.view];
    trailing.constant = -myMargin;

    [AutoLayout createGenericConstraintFrom:messageLabel toView:self.view withAttribute:NSLayoutAttributeCenterY];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];

    messageLabel.text = [NSString stringWithFormat:@"Reservation At:%@\nRoom:%i\nFrom: %@ - %@",
                         self.room.hotel.name,
                         self.room.number,
                         [formatter stringFromDate:self.startDate],
                         [formatter stringFromDate:self.endDate]];

}

-(void)setupTextFields {
    //create text fields
    self.firstName = [[UITextField alloc]init];
    self.firstName.placeholder = @"Please enter your first name";
    self.lastName = [[UITextField alloc]init];
    self.lastName.placeholder = @"Please enter your last name";
    self.email = [[UITextField alloc]init];
    self.email.placeholder = @"Please enter your email address";

    //I'll give the constraint flag
    [self.firstName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.lastName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.email setTranslatesAutoresizingMaskIntoConstraints:NO];

    //add textfields to view
    [self.view addSubview:self.firstName];
    [self.view addSubview:self.lastName];
    [self.view addSubview:self.email];

    //Layout textfields - firstName
    CGFloat myMargin = 20.0;
    CGFloat navAndStatusBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame) + myMargin;

    NSLayoutConstraint *top =[AutoLayout createGenericConstraintFrom:self.firstName toView:self.view withAttribute:NSLayoutAttributeTop];
    top.constant = navAndStatusBarHeight + myMargin;

    NSLayoutConstraint *leading = [AutoLayout createLeadingConstraintFrom:self.firstName toView:self.view];
    leading.constant = myMargin;

    NSLayoutConstraint *trailing = [AutoLayout createTrailingConstraintFrom:self.firstName toView:self.view];
    trailing.constant = -myMargin;

    //Layout textfields - lastName
    top =[AutoLayout createGenericConstraintFrom:self.lastName toView:self.firstName withAttribute:NSLayoutAttributeTop];
    top.constant = myMargin + 20;

    leading = [AutoLayout createLeadingConstraintFrom:self.lastName toView:self.view];
    leading.constant = myMargin;

    trailing = [AutoLayout createTrailingConstraintFrom:self.lastName toView:self.view];
    trailing.constant = -myMargin;

    //Layout textfields - email
    top =[AutoLayout createGenericConstraintFrom:self.email toView:self.lastName withAttribute:NSLayoutAttributeTop];
    top.constant = myMargin + 20;

    leading = [AutoLayout createLeadingConstraintFrom:self.email toView:self.view];
    leading.constant = myMargin;

    trailing = [AutoLayout createTrailingConstraintFrom:self.email toView:self.view];
    trailing.constant = -myMargin;

    [self.firstName becomeFirstResponder];

}

-(void)saveButtonSelected:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;

    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];

    reservation.startDate = [NSDate date];
    reservation.endDate = self.endDate;
    reservation.room = self.room;

    //does pointer manipulation below to add and create new array and assign that to itself.
    //kind of like this: constraints = [constraints arrayByAddingObjectsFromArray:horizantalConstraints];
    self.room.reservations = [self.room.reservations setByAddingObject:reservation];

    reservation.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
    reservation.guest.firstName = self.firstName.text;
    reservation.guest.lastName = self.lastName.text;
    reservation.guest.email = self.email.text;

    NSError *saveError;
    [context save:&saveError];

    if(saveError){
        NSLog(@"There was an error saving new reservation.");
    } else {
        NSLog(@"Saving successfull");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
